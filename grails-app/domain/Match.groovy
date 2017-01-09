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
class Match {
    static hasMany = [team1Players: Player, team2Players: Player]
    //Set team1Players
    //Set team2Players
    static mapping = {
        team1Players joinTable: [name: 'team1Players']
        team2Players joinTable: [name: 'team2Players']
    }
    Date date
    Double elo = 0
    Double matchQuality
    Integer game1Team1 = 0
    Integer game1Team2 = 0
    Integer game2Team1 = 0
    Integer game2Team2 = 0
    Integer game3Team1 = 0
    Integer game3Team2 = 0
    Integer result = 0
    Integer scoreTeam1 = 0
    Integer scoreTeam2 = 0

    def win(side) {
        if (side == 1 && result > 0) {
            return "win"
        }
        if (side == 2 && result < 0) {
            return "win"
        }
        return "loose"
    }

    def myValidate() {
        validate()
        if (team1Players == null || team1Players.size() == 0) {
            errors.rejectValue('team1Players', "invalid.match")
        }
        if (team2Players == null || team2Players.size() == 0) {
            errors.rejectValue('team2Players', "invalid.match")
        } else {
            team2Players.each { p ->
                if (team1Players?.contains(p)) {
                    errors.rejectValue('team2Players', "invalid.player")
                }
            }
        }

    }

    def String toString() {
        dump()
    }

    static constraints = {
        team1Players(size: 1..2)
// doesn't work, because if val==null it's never called, nullable=false also doesnt work, because the hibernate tables are wrong
//        	validator: {
//			   val, obj -> 
//			       if(val == null || val.size() < 1 || val.size() > 2) {
//			   	      return ["invalid.match"]
//			   	  }
//			}

        team2Players(size: 1..2)
        result(nullable: true)
        scoreTeam1(nullable: true)
        scoreTeam2(nullable: true)
        matchQuality(nullable: true)

        game1Team2(
                validator: {
                    val, obj ->
                        if (!(obj.properties['game1Team1'] != val && (obj.properties['game1Team1'] > 0 || val > 0))) return ["invalid.game"]
                }
        )
        //game2Team2(
        //	validator: {
        //	   val, obj ->
        //	      if(! (obj.properties['game2Team1']!= new Integer(val) && (obj.properties['game2Team1'] > 0 || new Integer(val) > 0))) return ["invalid.game"]
        //	}
        //)
        game1Team1(
                validator: {
                    val, obj ->
                        if (!(obj.properties['game1Team2'] != val && (obj.properties['game1Team2'] > 0 || val > 0))) return ["invalid.game"]
                }
        )
        game2Team1(
                validator: {
                    val, obj ->
                        if (!(obj.properties['game2Team2'] != val && (obj.properties['game2Team2'] > 0 || val > 0) && (obj.properties['game1Team1'] - obj.properties['game1Team2']) != 0)) return ["invalid.game"]
                }
        )
        game3Team2(
                validator: {
                    val, obj ->
                        (obj.properties['game3Team1'] == 0 && val == 0) || (obj.properties['game3Team1'] > 0 || val > 0)
                }
        )
    }
}
