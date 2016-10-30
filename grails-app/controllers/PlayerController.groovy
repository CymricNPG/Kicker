/**
 *   A simple foosball management application
 *   Copyright (C) 2015 Roland Spatzenegger
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see http://www.gnu.org/licenses/.
 */

import org.hibernate.*
import org.apache.commons.logging.LogFactory

class PlayerController {

    private static final log = LogFactory.getLog(this)

    def beforeInterceptor = [action: this.&checkUser, except: ['help', 'login', 'doLogin', 'index', 'list', 'show', 'create', 'save', 'extended']]

    def scoreService

    def SessionFactory sessionFactory

    def index = { redirect(action: list, params: params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    /**
     * Enter god mode
     */

    def admin = {
        session.user = "nobody"
        redirect(controller: 'match', action: 'list')
    }

    /**
     * leave god mode
     */

    def logout = {
        session.user = null
        redirect(controller: 'match', action: 'list')
    }

    /**
     * help page
     */
    def help = {}

    /**
     * checks if an user is logged in
     * @return false if user isn't logged in
     */
    def checkUser() {
        if (!session.user) {
            // i.e. user not logged in
            redirect(controller: 'player', action: 'list')
            return false
        }
        return true
    }

    /**
     * list all players
     */
    def list = {
        if (!params.max) {
            params.max = 40
        }
        if (!params.sort) {
            params.sort = "mean"
        }
        if (!params.order) {
            params.order = "desc"
        }
        def players = null


        def goalsScored = [:]
        def goalsDiffed = [:]
        def roundsPlayed = [:]
        Match.list().each { match ->
            def goals1 = (match.game1Team1 ?: 0) + (match.game2Team1 ?: 0) + (match.game3Team1 ?: 0)
            def goals2 = (match.game1Team2 ?: 0) + (match.game2Team2 ?: 0) + (match.game3Team2 ?: 0)
            def goalsDiff = goals1 - goals2
            def rounds = toInt01(match.game1Team1, match.game1Team2) +
                    toInt01(match.game2Team1, match.game2Team2) +
                    toInt01(match.game3Team1, match.game3Team2)
            match.team1Players.each { p ->
                goalsScored[p.id] = (goalsScored[p.id] ?: 0) + goals1
                roundsPlayed[p.id] = (roundsPlayed[p.id] ?: 0) + rounds
                goalsDiffed[p.id] = (goalsDiffed[p.id] ?: 0) + goalsDiff
            }
            match.team2Players.each { p ->
                goalsScored[p.id] = (goalsScored[p.id] ?: 0) + goals2
                roundsPlayed[p.id] = (roundsPlayed[p.id] ?: 0) + rounds
                goalsDiffed[p.id] = (goalsDiffed[p.id] ?: 0) - goalsDiff
            }
        }
        // now calc prop to win or loose with a certain partner...
        def goalsRatio = [:]
        def goalsDiff = [:]
        Player.list().each { p ->
            if (goalsScored[p.id] != null) {
                goalsRatio[p.id] = goalsScored[p.id] / roundsPlayed[p.id]
                goalsDiff[p.id] = goalsDiffed[p.id] / roundsPlayed[p.id]
            } else {
                goalsRatio[p.id] = 0.0
                goalsDiff[p.id] = 0.0
            }
        }
        def ratings = scoreService.calcSkills()
        if (!params.order) {
            params.order = "desc"
        }
        if (params.sort == 'goals') {
            players = sortPlayersByFunc(params.order, { p -> goalsRatio[p.id] })
        } else if (params.sort == 'diffs') {
            players = sortPlayersByFunc(params.order, { p -> goalsDiff[p.id] })
        } else if (params.sort == 'mean') {
            players = sortPlayersByFunc(params.order, { p -> ratings[p.id].getMean() })
        } else if (params.sort == 'deviation') {
            players = sortPlayersByFunc(params.order, { p -> ratings[p.id].getStandardDeviation() })
        } else if (params.sort == 'matchesWon' || params.sort == 'matchesLost' || params.sort == 'matchesDraw') {
            players = sortPlayers(params.sort, params.order)
        } else if (params.sort == 'avgScore') {
            players = sortPlayersAvgScore(params.order)
        } else {
            players = Player.list(params)
        }

        [playerList  : players.findAll {
            !it.deactivated
        }, goalsRatio: goalsRatio, goalsDiff: goalsDiff, ratings: ratings]
    }

    def sortPlayersAvgScore(order) {
        return sortPlayersByFunc(order, { p -> p.scoreAVG() })
    }

    def sortPlayersByFunc(order, attribFunc) {

        return Player.list().sort { p1, p2 ->
            if (order == 'asc') {
                return attribFunc(p1) <=> attribFunc(p2)
            } else {
                return attribFunc(p2) <=> attribFunc(p1)
            }
        }
    }

    /**
     * sort by matchesWon,matchesLost,matchesDraw
     */
    def sortPlayers(field, order) {
        def players = null

        players = Player.list(params).sort { p1, p2 ->
            def p1Matches = Math.max(p1.matchesWon + p1.matchesLost + p1.matchesDraw, 1)
            def p2Matches = Math.max(p2.matchesWon + p2.matchesLost + p2.matchesDraw, 1)
            if (order == 'asc') {
                return p1.properties[field] / p1Matches <=> p2.properties[field] / p2Matches
            } else {
                return p2.properties[field] / p2Matches <=> p1.properties[field] / p1Matches
            }
        }
        return players
    }
    /**
     * show details of a player
     */
    def show = {
        def p = Player.get(params.id)
        def pid = p.id
        def elos = []

        // get the list of matches for a user
        def c = Match.createCriteria()
        def matchList = c.list {
            or {
                team1Players {
                    eq("id", pid)
                }
                team2Players {
                    eq("id", pid)
                }
            }
            distinct("id")
            order("id", "asc")
        }.unique()

        def result = scoreService.recalcSkills()
        def curve = []
        def count = 0
        result.skillHistory[pid]?.each { rating ->
            def mean = rating.getMean()
            curve.add([count, mean, mean - rating.getStandardDeviation(), mean + rating.getStandardDeviation()])
            count++
        }


        def maxMatches = matchList.size();

        // match list with paginate
        def offset = params?.offset != null ? params.offset.toInteger() * 2 : 0
        def sort = params?.sort != null ? params.sort : 'date'
        def orderX = params?.order != null ? params.order : 'desc'
        c = Match.createCriteria()
        matchList = c.list {
            or {
                team1Players {
                    eq("id", p.id)
                }
                team2Players {
                    eq("id", p.id)
                }
            }
            order(sort, orderX)
            maxResults(20)
            firstResult(offset)
        }.unique()
        // hack ... evict elements from 1st cache
        def hibSession = sessionFactory.getCurrentSession()
        def retList = []
        matchList.each { match ->
            hibSession.evict(match)
            retList.add(Match.get(match.id))
        }


        return [player: p, curve: curve, matchList: retList, maxMatches: maxMatches]
    }

    def delete = {
        def player = Player.get(params.id)
        if (player) {
            player.delete()
            flash.message = "Player ${params.id} deleted"
            redirect(action: "list")
        } else {
            flash.message = "Player not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def edit = {
        def player = Player.get(params.id)

        if (!player) {
            flash.message = "Player not found with id ${params.id}"
            redirect(action: "list")
        } else {
            return [player: player]
        }
    }

    def update = {
        def player = Player.get(params.id)
        if (player) {
            log.info("Parameters:" + params)
            params.matchesWon = 0
            params.matchesLost = 0
            params.matchesDraw = 0
            player.properties = params
            if (!player.hasErrors() && player.save()) {
                flash.message = "Player ${params.id} updated"
                redirect(action: 'show', id: player.id)
            } else {
                render(view: 'edit', model: [player: player])
            }
        } else {
            flash.message = "Player not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def create = {
        def player = new Player()
        player.properties = params
        return ['player': player]
    }

    def save = {
        params.matchesWon = 0
        params.matchesLost = 0
        params.matchesDraw = 0
        def player = new Player(params)

        if (!player.hasErrors() && player.save()) {
            flash.message = "Player ${player.id} created"
            redirect(action: "show", id: player.id)
        } else {
            render(view: 'create', model: [player: player])
        }
    }


    def toInt01(value1, value2) {
        if (value1 != null && value1 > 0) {
            return 1
        }
        if (value2 != null && value2 > 0) {
            return 1
        }
        return 0
    }
}