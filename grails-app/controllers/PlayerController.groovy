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
 
import org.hibernate.*
import org.apache.commons.logging.LogFactory

class PlayerController {
    
	private static final log = LogFactory.getLog(this)
	
	def beforeInterceptor = [action:this.&checkUser,except:['help','login', 'doLogin', 'index','list','show','create', 'save']]
    
    def scoreService 
    
    def SessionFactory sessionFactory
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete:'POST', save:'POST', update:'POST']

    /**
     * login a user
     */

	def login = {
	}
    
    /**
     * logout a logged in user
     */

    def logout = {
        session.user = null
        redirect(action:list)
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
		if(!session.user) {
			// i.e. user not logged in
			redirect(controller:'player',action:'login')
			return false
		}
	}
	
	def doLogin = {
		def player = Player.findWhere(name:params['name'])
		if(player?.password != null && params?.password != null && player.password.length() > 0
		        &&  params.password.length()>0) {
    		if(player.password != params.password.encodeAsPassword()) {
    		    player = null
    		}
		}
		session.user = player
		if (player)
			redirect(controller:'match',action:'list')
		else
			redirect(controller:'player',action:'login')
	}
	/**
	 * list all players
	 */
    def list = {
        if(!params.max) {
         	params.max = 20
        }
        if(!params.sort) {
            params.sort = "name"
        }  
        def players = null
        // this is a crap hack ... if the property is unknown I get a spring exception
        if(params.sort == 'id') {
            if( params.order == 'asc') {
                players = sortPlayers('score','asc')
            } else {
                players = sortPlayers('score','dsc')
            }
        } else if(params.sort == 'matchesWon' || params.sort == 'matchesLost' || params.sort == 'matchesDraw' ) {
            if( params.order == 'asc') {
                players = sortPlayers(params.sort,'asc')
            } else {
                players = sortPlayers(params.sort,'dsc')
            }
        } else {
            players = Player.list( params )
        }
        [ playerList: players ]
    }
    /**
     * sort by matchesWon,matchesLost,matchesDraw
     */
	def sortPlayers(field, order) {
	    def players = null
	    if(order == 'asc') {
    	    players = Player.list( params ).sort{ p1,p2 -> 
                def p1Matches =  Math.max(p1.matchesWon+p1.matchesLost+p1.matchesDraw,1)
                def p2Matches =  Math.max(p2.matchesWon+p2.matchesLost+p2.matchesDraw,1)
                return p1.properties[field]/p1Matches <=> p2.properties[field]/p2Matches
            }
	    } else {
	        players = Player.list( params ).sort{ p2,p1 -> 
                def p1Matches =  Math.max(p1.matchesWon+p1.matchesLost+p1.matchesDraw,1)
                def p2Matches =  Math.max(p2.matchesWon+p2.matchesLost+p2.matchesDraw,1)
                return p1.properties[field]/p1Matches <=> p2.properties[field]/p2Matches
            }
	    }
	    return players
	}
	/**
	 * show details of a player
	 */
    def show = {
	    def p = Player.get( params.id )
	    def elos = [] 
	    def eloStart = 1000
	    def count = 0
	    def k = 25

	    // get the list of matches for a user
	    def c = Match.createCriteria()
	    def matchList = c.list{ 	        
	        or {
	            team1Players {
	                eq("id", p.id)
	            }
	            team2Players {
	                eq("id", p.id)
	            }
            } 
	    }.unique()
	    
	    // calculate the elo history
	    matchList.each { match ->
	        def elo = scoreService.returnElo(match, p)
	        if(elo != 0) {
	            eloStart += elo*k
	            elos.add([count,eloStart])
		        count++
	            if(count >= 30) {
		            k = 15
		        }
	        }
	       
    	}    
	    def maxMatches = matchList.size();

	    // match list with paginate
	    def offset = params?.offset != null ? params.offset.toInteger()*2 : 0
	    def sort = params?.sort != null ? params.sort : 'date'
	    def orderX = params?.order != null ? params.order : 'desc'
	    c = Match.createCriteria()
	    matchList = c.list{ 	
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
//	    println retList[0].team1Players
//	    println retList[0].team2Players

	    return [ player : p, elos : elos, matchList:retList, maxMatches : maxMatches]
    }

    def delete = {
        def player = Player.get( params.id )
        if(player) {
            player.delete()
            flash.message = "Player ${params.id} deleted"
            redirect(action:"list")
        }
        else {
            flash.message = "Player not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def player = Player.get( params.id )

        if(!player) {
            flash.message = "Player not found with id ${params.id}"
            redirect(action:"list")
        }
        else {
            return [ player : player ]
        }
    }

    def update = {
        def player = Player.get( params.id )
        if(player) {
            if(!params?.password.equals(params?.password2)) {
                player.errors.rejectValue('password', 'player.password.doesnotmatch')
            }
            params.matchesWon = 0
            params.matchesLost = 0
            params.matchesDraw = 0
            player.properties = params
            player.password = params.password.encodeAsPassword()
            if(!player.hasErrors() && player.save() ) {
                flash.message = "Player ${params.id} updated"
                redirect(action:show,id:player.id)
            }
            else {
                render(view:'edit',model:[player:player])
            }
        }
        else {
            flash.message = "Player not found with id ${params.id}"
            redirect(action:"edit",id:params.id)
        }
    }

    def create = {
        def player = new Player()
        player.properties = params
        return ['player':player]
    }

    def save = {
        params.matchesWon = 0
        params.matchesLost = 0
        params.matchesDraw = 0
        def player = new Player(params)

        if(!player.hasErrors() && player.save()) {
            flash.message = "Player ${player.id} created"
            redirect(action:"show", id:player.id)
        }
        else {
            render(view:'create',model:[player:player])
        }
    }
}