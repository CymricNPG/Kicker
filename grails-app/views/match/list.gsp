  
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Match List</title>
    </head>
    <body>
        <g:render template="/match/match_menu" />
        <div class="body">
            <h1>Match List</h1>
            <g:if test="${flash?.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="normal" >
                    <thead>
                        <tr> 
                   	        <g:sortableColumn property="id" title="Id"/>
                   	        <g:sortableColumn property="date" title="Date"/>
                         	<th> Team 1 </th>
                         	<th> Team 2 </th>
                         	<th> Game 1 </th>
                         	<th> Game 2 </th>
                         	<th> Game 3 </th>
                         	<th> Result </th>
                         	<g:sortableColumn property="elo" title="ELO"/>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${matchList}" status="i" var="match">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${match.id}">${match.id?.encodeAsHTML()}</g:link></td>
                        
                            <td>${match.date?.encodeAsHTML()}</td>
                            <td class="${match.win(1)}">
	                             <g:each in="${match.team1Players}" var="player">
	                             <g:link controller="player" action="show" id="${player.id}">
	                             	${player.name}
	                             </g:link> <br/>
	                             </g:each>
                            </td>
	                        <td class="${match.win(2)}">
	                             <g:each in="${match.team2Players}" var="player">
	                             <g:link controller="player" action="show" id="${player.id}">
	                             	${player.name}
	                             </g:link> <br/>
	                             </g:each>
                            </td>
						  <td>${match.game1Team1}:${match.game1Team2}</td>
						  <td>${match.game2Team1}:${match.game2Team2}</td>
						  <td>${match.game3Team1}:${match.game3Team2}</td>
						  <td>${match.result}</td>    
						   <td>${String.format("%.3f",match.elo)}</td>                         
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${Match.count()}" />
            </div>
        </div>
    </body>
</html>
