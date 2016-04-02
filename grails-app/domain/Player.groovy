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
 class Player {
	String name
	Integer matchesWon = 0
	Integer matchesLost = 0
	Integer matchesDraw = 0
	Integer score = 0
	String password = "" // needed for older installations
	Double elo = 1000
    Double mean
    Double standardDeviation

	def scoreAVG() {
		def matches = totalMatches()
		if(matches == 0) {
			return 0.0
		}
		return score / matches
	}

	def totalMatches() {
		return matchesWon+matchesLost+matchesDraw
	}

	/**
	 * tokenizes the name and shortens all nouns after the first one
	 */
	def shortName() {
	    def nouns = name.tokenize(" ")
	    def sname = nouns[0]
	    if(nouns.size()>1) {
    	    for(i in 1..(nouns.size()-1)) {
    	        sname = sname + " " + nouns[i][0]+"."
    	    }
        }
	    return sname
	}

	static constraints = {
        name(size:1..12, blank:false, unique:true)
        matchesWon(nullable:false)
        matchesLost(nullable:false)
        matchesDraw(nullable:false)
        mean(nullable: true)
        standardDeviation(nullable: true)
    }

}
