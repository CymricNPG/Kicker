
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Player List</title>
    </head>
    <body>
        <g:render template="/player/player_menu" />
        <div class="body">
            <h1>Player List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="normal">
                    <thead>
                        <tr>
                        	<g:sortableColumn property="name" title="Name" />
                        	<g:sortableColumn property="score" title="Score" style="width: 40px" />
                        	<g:sortableColumn property="id" title="avg. Score" style="width: 70px" />
                        	<g:sortableColumn property="elo" title="ELO" style="width: 40px"/>
                   	        <g:sortableColumn property="matchesWon" title="Matches Won" />
                   	        <g:sortableColumn property="matchesLost" title="Matches Lost" />
                  	        <g:sortableColumn property="matchesDraw" title="Matches Draw" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${playerList}" status="i" var="player">
                    	<g:set var="nrOfMatches" value="${Math.max(player.totalMatches(), 1)}" />
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        	<td><g:link action="show" id="${player.id}">${player.name?.encodeAsHTML()}</g:link></td>
                        	<g:if test="${nrOfMatches>4}">
                        	<td>${String.format("%d",player.score)}</td>
                            <td>${String.format("%.2f",player.scoreAVG())}</td>
                            <td>${String.format("%.0f",player.elo)}</td>
                            <td>${String.format("%.0f",player.matchesWon/nrOfMatches*100)}% </td>
                            <td>${String.format("%.0f",player.matchesLost/nrOfMatches*100)}% </td>
                            <td>${String.format("%.0f",player.matchesDraw/nrOfMatches*100)}% </td>
                            </g:if>
                            <g:else><td class="grey">player</td>
                            <td class="grey">has</td>
                            <td class="grey">less</td>
                            <td class="grey">than </td>
                            <td class="grey"> 5  </td>
                            <td class="grey">matches </td></g:else>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${Player.count()}" />
            </div>
        </div>
    </body>
</html>
