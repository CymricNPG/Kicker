import org.apache.commons.logging.LogFactory

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
class ScoreService {

    private static final log = LogFactory.getLog(this)
    boolean transactional = false

    /**
     * recalculates the elo and scores for all players and all matches
     */
    def recalcMatchScore() {
        def players = Player.list()
        players.each { player ->
            player.elo = 1000
            player.matchesWon = 0
            player.matchesDraw = 0
            player.matchesLost = 0
            player.score = 0
            player.save()
        }
        def results = Match.listOrderById()
        results.each { match ->
            calcElo(match)
            match.save()
        }
    }

    /**
     * returns the elo of a player in a particular game without K Factor
     * @reurn 0 if player wasnt part of the game
     */

    def returnElo(Match match, Player player) {
        def elo = 0
        match.team1Players.each { p ->
            if (p.id == player.id) {
                if (match.result > 0) {
                    elo = 1 - match.elo
                }
                if (match.result == 0) {
                    elo = 0.5 - match.elo
                }
                if (match.result < 0) {
                    elo = 0.0 - match.elo
                }
            }
        }
        match.team2Players.each { p ->
            if (p.id == player.id) {
                if (match.result < 0) {
                    elo = 1 - (1 - match.elo)
                }
                if (match.result == 0) {
                    elo = 0.5 - (1 - match.elo)
                }
                if (match.result > 0) {
                    elo = 0.0 - (1 - match.elo)
                }
            }
        }
        def matchFactor = calcMatchFactor(match.result)
        return elo * matchFactor
    }


    def calcMatchFactor(matchresult) {
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
     * calculate the elo of a match. Inserts all calculated values in the match object
     */
    def calcElo(match) {
        def ra = 0.0
        def rb = 0.0
        def rac = 0
        def rbc = 0
        match.team1Players.each { p ->
            ra += p.elo
            rac++
        }
        match.team2Players.each { p ->
            rb += p.elo
            rbc++
        }
        // average of elos
        if (rac > 0 && rbc > 0) {
            ra = ra / (double) rac
            rb = rb / (double) rbc
            // the match elo
            match.elo = 1 / (1 + Math.pow(10.0, (rb - ra) / 400.0))
        }

        def matchFactor = calcMatchFactor(match.result)

        /* calculate player scores */
        match.team1Players.each { p ->
            updateScore(match, match.elo, p, matchFactor, -11)
            p.score += match.scoreTeam1
            p.save()
        }
        match.team2Players.each { p ->
            updateScore(match, 1.0 - match.elo, p, matchFactor, 1)
            p.score += match.scoreTeam2
            p.save()
        }
    }

    def updateScore(match, elo, player, matchFactor, side) {
        def k = calcK(player)
        k = k * matchFactor
        def fac = 0.0
        if (match.result * side < 0) {
            player.matchesWon++
            fac = k * (1.0 - match.elo)
        }
        if (match.result == 0) {
            player.matchesDraw++
            fac = +k * (0.5 - match.elo)
        }
        if (match.result * side > 0) {
            player.matchesLost++
            fac = k * (0.0 - match.elo)
        }
        player.elo += fac
        log.info "Match," + match.date.toString() + ",Player," + player.name.toString() + ",Fac," + fac
    }

    def calcKGeneric(totalMatches, elo) {
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

    /**
     * calculates the facor k for a player
     */
    def calcK(p) {
        return calcKGeneric(p.matchesDraw + p.matchesWon + p.matchesLost, p.elo)
    }

    def recalcAndUpdateElo() {
        def result = recalculateElo()
        Match.list().each { match ->
            match.elo = result.matchElos[match.id]
            match.save()
        }
        Player.list().each { player ->
            player.elo = result.playerElos[player.id]
            player.score = result.playerScores[player.id]
            player.matchesWon = result.matchesWon[player.id]
            player.matchesDraw = result.matchesDraw[player.id]
            player.matchesLost = result.matchesLost[player.id]
            player.save()
        }
    }

    // calculate all match and player elos, return as maps
    def recalculateElo() {
        def result = new ScoreResult()
        Player.list().each { player ->
            result.playerElos[player.id] = 1000.0
            result.playerScores[player.id] = 0
            result.matchesWon[player.id] = 0
            result.matchesDraw[player.id] = 0
            result.matchesLost[player.id] = 0
            result.eloHistory[player.id] = [:]
        }
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
}
