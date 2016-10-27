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

import org.apache.commons.logging.LogFactory

class MatchController {

    private static final log = LogFactory.getLog(this)

    def scoreService

    def beforeInterceptor = [action: this.&checkUser, except: ['statistics', 'help', 'index', 'list', 'show', 'create', 'save']]


    def index = { redirect(action: list, params: params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    /**
     * checks if user is logged in
     */
    def checkUser() {
        if (!session.user) {
            // i.e. user not logged in
            redirect(controller: 'player', action: 'login')
            return false
        }
    }

    /**
     * help page
     */
    def help = {}

    /**
     * shows player and match statistics
     */
    def statistics = {
        // blue/red statistics
        def blue = 0.0
        def red = 0.0
        //best partner statistics
        def partnersWon = [:]
        def partnersLost = [:]
        def hero_matches = [] as Set
        def heroes = [] as Set
        def losers = [] as Set

        Match.list().each { match ->

            if (match.result > 0) {
                blue++
                if (match.team1Players.size() == 2) {
                    def id = getPartnerString(match.team1Players);
                    partnersWon[id] = (partnersWon[id] ?: 0) + 1;
                }
                if (match.team2Players.size() == 2) {
                    def id = getPartnerString(match.team2Players);
                    partnersLost[id] = (partnersLost[id] ?: 0) + 1;
                }
            } else {
                red++
                if (match.team2Players.size() == 2) {
                    def id = getPartnerString(match.team2Players);
                    partnersWon[id] = (partnersWon[id] ?: 0) + 1;
                }
                if (match.team1Players.size() == 2) {
                    def id = getPartnerString(match.team1Players);
                    partnersLost[id] = (partnersLost[id] ?: 0) + 1;
                }
            }

            if ((match.game1Team1 == 0 && match.game1Team2 > 0) ||
                    (match.game2Team1 == 0 && match.game2Team2 > 0) ||
                    (match.game3Team1 == 0 && match.game3Team2 > 0)) {
                hero_matches.add(match)
                heroes.addAll(match.team2Players)
                losers.addAll(match.team1Players)
            }

            if ((match.game1Team1 > 0 && match.game1Team2 == 0) ||
                    (match.game2Team1 > 0 && match.game2Team2 == 0) ||
                    (match.game3Team1 > 0 && match.game3Team2 == 0)) {
                hero_matches.add(match)
                losers.addAll(match.team2Players)
                heroes.addAll(match.team1Players)
            }
        }
        // now calc prop to win or loose with a certain partner...
        def partnerArray = []
        def players = []
        def partnersScore = [:]
        def minMatches = 4
        Player.listOrderByName().each { p1 ->
            def line = []
            players << p1.id

            Player.listOrderByName().each { p2 ->
                def id = p1.id + ":" + p2.id
                //println id +"/"+partnersWon[id]+"/"+partnersLost[id]
                def won = partnersWon[id] ?: 0
                def lost = partnersLost[id] ?: 0
                def allGames = won + lost
                def r = allGames != 0 ? (won - lost) * 10 / allGames : 0
                if ((won + lost) >= minMatches) {
                    line << r.toInteger()
                    partnersScore[id] = r;
                } else {
                    line << null
                }
            }
            partnerArray << line
        }
        // get most successful teams
        def redblue = red + blue
        def redPercent = redblue == 0 ? 0 : red * 100 / redblue
        def bluePercent = redblue == 0 ? 0 : blue * 100 / redblue

        return [red          : redPercent,
                blue         : bluePercent,
                partnerArray : partnerArray,
                players      : players,
                partnersScore: partnersScore,
                minMatches   : minMatches,
                hero_matches : hero_matches.unique(),
                losers       : losers.unique(),
                heroes       : heroes.unique()
        ]
    }
    /**
     * helper method for statistics
     */
    def getPartnerString(players) {
        def list = getPlayersAsList(players)
        def pl1 = list[0].name < list[1].name ? list[0].id : list[1].id;
        def pl2 = list[0].name > list[1].name ? list[0].id : list[1].id;
        def id = pl1 + ":" + pl2;
        return id
    }

    def getPlayersAsList(players) {
        def list = []
        list.addAll(players)
        return list
    }
    /**
     * shows a list of games, default sorting is by date
     */
    def list = {
        if (!params.max) {
            params.max = 10
        }
        if (!params.sort) {
            params.sort = "date"
            params.order = "desc";
        }
        [matchList: Match.list(params), maxMatches: Match.count()]
    }

    /**
     * show a match
     */
    def show = {
        [match: Match.get(params.id)]
    }
    /**
     * delete a match
     */
    def delete = {
        def match = Match.get(params.id)
        if (match) {
            match.delete()
            flash.message = "Match ${params.id} deleted. (After deletion you have to recalculate the ELO values.)"
            redirect(action: "list")
        } else {
            flash.message = "Match not found with id ${params.id}"
            redirect(action: "list")
        }
    }
    /**
     * start recalculation of the elos
     */
    def recalc = {
        scoreService.recalcAndUpdateElo()
        flash.message = "ELO of all Players recalculated."
        redirect(action: "list")
    }
    /**
     * edit a match
     */
    def edit = {
        def match = Match.get(params.id)

        if (!match) {
            flash.message = "Match not found with id ${params.id}"
            redirect(action: "list")
        } else {
            return [match: match]
        }
    }

    /**
     * update a match in the database
     */
    def update = {
        def match = Match.get(params.id)
        if (match) {
            def paramsRet = initParams(params)
            if (!paramsRet) {
                flash.message = "You can only set Result or Quick Result."
                render(view: 'edit', model: [match: match])
                return
            }
            match.properties = paramsRet
            match.team1Players?.clear()
            match.team2Players?.clear()
            addTeams(match, paramsRet)
            match.myValidate()
            if (!match.hasErrors() && match.save()) {
                flash.message = "Match ${params.id} updated"
                redirect(action: "show", id: match.id)
            } else {
                render(view: 'edit', model: [match: match])
            }
        } else {
            flash.message = "Match not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }
    /**
     * create a new match
     */
    def create = {
        def match = new Match()
        return ['match': match]
    }

    def stringToInteger(name, params) {
        params[name] = params.int(name)
        if (params[name] == null) {
            params[name] = 0;
        }
    }

    /**
     * converts all parameters from the web to internal parameters
     * @return null if quick result and normal result are set
     */
    def initParams(params) {

        // convert string values to integers
        stringToInteger("game1Team1", params)
        stringToInteger("game1Team2", params)
        stringToInteger("game2Team1", params)
        stringToInteger("game2Team2", params)
        stringToInteger("game3Team1", params)
        stringToInteger("game3Team2", params)
        stringToInteger("gamesTeam1Won", params)
        stringToInteger("gamesTeam2Won", params)

        if ((params.gamesTeam1Won > 0 || params.gamesTeam2Won > 0) &&
                (params.game1Team1 > 0 || params.game1Team2 > 0)) {
            // error if both  (quick result and exact goals) filled out
            return
        }
        if (params.gamesTeam1Won > 0 || params.gamesTeam2Won > 0) {
            // quick result ...
            def r = params.gamesTeam1Won - params.gamesTeam2Won
            params.game1Team1 = r >= 0 ? 1 : 0
            params.game1Team2 = r < 0 ? 1 : 0
            params.game2Team1 = (r == 2 || r == -1) ? 1 : 0
            params.game2Team2 = (r == 2 || r == -1) ? 0 : 1
            params.game3Team1 = (r == 1) ? 1 : 0
            params.game3Team2 = (r == -1) ? 1 : 0
        }
        // get the winner of a game
        def g1 = Integer.signum(params.game1Team1 - params.game1Team2)
        def g2 = Integer.signum(params.game2Team1 - params.game2Team2)
        def g3 = Integer.signum(params.game3Team1 - params.game3Team2)
        // calculate the score
        params.result = g1 + g2 + g3
        params.scoreTeam1 = params.result
        params.scoreTeam2 = -params.result
        return params
    }

    /**
     * adds the team-members to a match
     */
    def addTeams(match, params) {
        def matchTeam1Players = params.matchTeam1Players instanceof String ? [params.matchTeam1Players] : params.matchTeam1Players
        def matchTeam2Players = params.matchTeam2Players instanceof String ? [params.matchTeam2Players] : params.matchTeam2Players
        matchTeam1Players.each { r ->
            def p = Player.get(r)
            match.addToTeam1Players(p)
        }

        matchTeam2Players.each { r ->
            def p = Player.get(r)
            match.addToTeam2Players(p)
        }
    }
    /**
     * saves a new match
     */
    def save = {
        def paramsRet = initParams(params)
        if (!paramsRet) {
            flash.message = "You can only set Result or Quick Result."
            def match = new Match()
            render(view: 'create', model: [match: match])
            return
        }
        def match = new Match(paramsRet)
        addTeams(match, paramsRet)

        match.myValidate()

        if (!match.hasErrors()) {
            if (!scoreService.calcElo(match)) {
                flash.message = "Error in calculation ELO, please contact admin. Params:" + paramsRet
                render(view: 'create', model: [match: match])
            } else {
                match.save()
                flash.message = "Match ${match.id} created."
                log.error("Match:" + match)
                redirect(action: "show", id: match.id)
            }
        } else {
            flash.message = "Params:" + paramsRet
            render(view: 'create', model: [match: match])
        }
    }
}