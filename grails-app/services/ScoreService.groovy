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


class ScoreService {

    private static final log = LogFactory.getLog(this)
    boolean transactional = false

    private def calcMatchFactor(matchresult) {
        // match factor (100% for draw, 75% for +/-1 matches (3 sets), 100% for +/-2 matches (2 sets)
        if (Math.abs(matchresult) == 0) {
            return 1
        }
        if (Math.abs(matchresult) == 1) {
            return 0.75
        }
        return 1.0
    }

    /**
     * calculate the elo of a match. Inserts all calculated values in the match object and updates player
     */
    def calcElo(match) {
        def players = []
        players.addAll(match.team1Players)
        players.addAll(match.team2Players)

        def result = new ScoreResult(players)
        calcElo(match, result)

        match.elo = result.matchElos[match.id]
        match.matchQuality = result.matchQuality[match.id]
        writePlayersBack(players, result)
    }

    private def calcKGeneric(totalMatches, elo) {
        if (totalMatches < 30) {
            return 25.0
        } else {
            if (elo < 2400) {
                return 15.0
            } else {
                return 10.0
            }
        }
    }

    private def writePlayersBack(players, result) {
        players.each { player ->
            def pid = player.id
            player.elo = result.playerElos[pid]
            player.score = result.playerScores[pid]
            player.matchesWon = result.matchesWon[pid]
            player.matchesDraw = result.matchesDraw[pid]
            player.matchesLost = result.matchesLost[pid]
            player.mean = result.ratings[pid].getMean()
            player.standardDeviation = result.ratings[pid].standardDeviation
            player.save()
        }
    }

    def recalcAndUpdateElo() {
        def result = recalculateElo()
        Match.list().each { match ->
            match.elo = result.matchElos[match.id]
            match.matchQuality = result.matchQuality[match.id]
            match.save()
        }
        writePlayersBack(Player.list(), result)
    }

    // calculate all match and player elos, return as maps
    def recalculateElo() {
        def result = new ScoreResult()
        log.info("Start calculating elos")
        Match.listOrderById().each { match ->
            calcElo(match, result)
        }
        return result
    }

    /**
     * calculate the elo of a match. Inserts all calculated values in the match object
     */
    def calcElo(match, result) {

        calcSkill(match, result) // hack

        def ra = 0.0
        def rb = 0.0
        def rac = 0
        def rbc = 0
        match.team1Players.each { p ->
            ra += result.playerElos[p.id]
            rac++
        }
        match.team2Players.each { p ->
            rb += result.playerElos[p.id]
            rbc++
        }

        if (rac == 0 || rbc == 0) {
            log.warn("Match:" + match.id + " is inconsistent. No players set.")
            return
        }
        ra = ra / (double) rac
        rb = rb / (double) rbc
        result.matchElos[match.id] = 1 / (1 + Math.pow(10.0, (rb - ra) / 400.0))

        /* calculate player scores */
        match.team1Players.each { p ->
            updateResult(match, result, p, -1)
            result.playerScores[p.id] += match.scoreTeam1
        }
        match.team2Players.each { p ->
            updateResult(match, result, p, 1)
            result.playerScores[p.id] += match.scoreTeam2
        }
    }

    def updateResult(match, result, player, side) {
        def pid = player.id
        def totalGames = result.matchesDraw[pid] + result.matchesWon[pid] + result.matchesLost[pid]
        def k = calcKGeneric(totalGames, result.playerElos[pid]) * calcMatchFactor(match.result)
        def fac = 0.0
        def elo = result.matchElos[match.id]
        if (match.result * side < 0) {
            result.matchesWon[pid]++
            fac = k * (1.0 - elo)
        }
        if (match.result == 0) {
            result.matchesDraw[pid]++
            fac = +k * (0.5 - elo)
        }
        if (match.result * side > 0) {
            result.matchesLost[pid]++
            fac = k * (0.0 - elo)
        }
        result.playerElos[pid] += fac
        result.eloHistory[pid][match.id] = result.playerElos[pid]
        //log.info "Match," + match.date.toString() + ",Player," + player.name.toString() + ",Fac," + fac + ",Elo," + result.playerElos[pid]
    }

    def calcSkills() {
        def result = new ScoreResult()
        Match.listOrderById().each { match ->
            calcSkill(match, result)
        }
        return result.ratings
    }

    def calcSkill(match, result) {
        def gameInfo = jskills.GameInfo.getDefaultGameInfo();
        def team1 = new jskills.Team()
        def team2 = new jskills.Team()
        match.team1Players.each { p ->
            team1.addPlayer(result.skillPlayers[p.id], result.ratings[p.id])
        }
        match.team2Players.each { p ->
            team2.addPlayer(result.skillPlayers[p.id], result.ratings[p.id])
        }
        def teams = jskills.Team.concat(team1, team2)
        def team1place = match.result >= 0 ? 1 : 2
        def team2place = match.result <= 0 ? 1 : 2
        def newRatingsWinLoseExpected = jskills.TrueSkillCalculator.calculateNewRatings(gameInfo, teams, team1place, team2place)
        newRatingsWinLoseExpected.each{ player, rating ->
            result.ratings[player.getId()] = rating
        }
        result.matchQuality[match.id] = jskills.TrueSkillCalculator.calculateMatchQuality(gameInfo, teams)
    }

}
