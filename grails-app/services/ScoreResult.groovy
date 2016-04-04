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

class ScoreResult {
    ScoreResult() {
        Player.list().each { player ->
            playerElos[player.id] = 1000.0
            playerScores[player.id] = 0
            matchesWon[player.id] = 0
            matchesDraw[player.id] = 0
            matchesLost[player.id] = 0
            eloHistory[player.id] = [:]
            ratings[player.id] = jskills.GameInfo.getDefaultGameInfo().getDefaultRating()
            skillPlayers[player.id] = new jskills.Player<Long>(player.id)
        }
    }

    ScoreResult(players) {
        players.each { player ->
            playerElos[player.id] = player.elo
            playerScores[player.id] = player.score
            matchesWon[player.id] = player.matchesWon
            matchesDraw[player.id] = player.matchesDraw
            matchesLost[player.id] = player.matchesLost
            eloHistory[player.id] = [:]
            if(player.mean == null || player.standardDeviation == null) {
                ratings[player.id] = jskills.GameInfo.getDefaultGameInfo().getDefaultRating()
            } else {
                ratings[player.id] = new jskills.Rating(player.mean, player.standardDeviation)
            }
            skillPlayers[player.id] = new jskills.Player<Long>(player.id)
        }
    }

    def matchElos = [:]
    def matchQuality = [:]
    def ratings = [:]
    def skillPlayers = [:]
    def playerElos = [:]
    def playerScores = [:]
    def matchesWon = [:]
    def matchesDraw = [:]
    def matchesLost = [:]
    def eloHistory = [:]
}
