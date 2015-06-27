/**
 *   A simple foosball management application
 *   Copyright (C) 2008 Roland Spatzenegger
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
     * returns the elo of a player in a particular game
     * @reurn 0 if player wasnt part of the game
     */
    def returnElo(Match match, Player player) {
        def elo = 0
        match.team1Players.each { p -> 
			if(p.id == player.id) {
			    if(match.result > 0) {
	    			elo = 1 - match.elo
	    		}
	    		if(match.result == 0) {
	    			elo = 0.5 - match.elo
	    		}
	    		if(match.result < 0) {
	    			elo = 0.0 - match.elo
	    		}
			}
		} 
        match.team2Players.each { p -> 
          	if(p.id == player.id) {
          	    if(match.result < 0) {
	    			elo = 1 - (1-match.elo)
	    		}
	    		if(match.result == 0) {
	    			elo = 0.5 - (1-match.elo)
	    		}
	    		if(match.result > 0) {
	    			elo = 0.0 - (1-match.elo)
	    		}
    		}
      	}  
      	def matchFactor = 1.0
		if( Math.abs(match.result) == 1 ) {
		    matchFactor = 0.75
		}
        return elo*matchFactor	
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
 	    if(rac > 0 && rbc > 0) {
	 	    ra = ra / (double) rac
	      	rb = rb / (double) rbc
	      	// the match elo
	    	match.elo = 1/( 1 + Math.pow(10.0, (rb-ra)/400.0)  )
    	}
		
		// match factor (75% for +/-1 matches, 100% for +/-2 matches
		def matchFactor = 1.0
		if( Math.abs(match.result) == 1 ) {
		    matchFactor = 0.75
		}
	
    	/* calculate player scores */
    	match.team1Players.each { p ->
    		def k = calcK(p)
    		k = k * matchFactor
    		if(match.result > 0) {
    			p.matchesWon++
    			p.elo = (p.elo + k * (1 - match.elo))
    		}
    		if(match.result == 0) {
    			p.matchesDraw++
    			p.elo = (p.elo + k * (0.5 - match.elo))
    		}
    		if(match.result < 0) {
    			p.matchesLost++
    			p.elo = (p.elo + k * (0.0 - match.elo))
    		}
			p.score += match.scoreTeam1
			p.save()
    	}
    	match.team2Players.each { p ->
    		def k = calcK(p)
    		k = k * matchFactor
    		if(match.result < 0) {
    			p.matchesWon++
    			p.elo = p.elo + k * (1.0 - (1.0 - match.elo))
    		}
    		if(match.result == 0) {
    			p.matchesDraw++
    			p.elo = p.elo + k * (0.5 - (1.0 - match.elo))
    		}
    		if(match.result > 0) {
    			p.matchesLost++
    			p.elo = p.elo + k * (0.0 - (1.0 - match.elo))
    		}
			p.score += match.scoreTeam2
			p.save()
		}
    }
    /**
     * calculates the facor k for a player
     */
	def calcK(p) {
		def k = 0.0
		if( (p.matchesDraw+p.matchesWon+p.matchesLost) < 30 ) {
			k = 25.0
		} else {
			if( p.elo < 2400 ) {
				k = 15.0
			} else {
				k = 10.0
			}
		}
		return k
	}
}
