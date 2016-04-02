
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
                             <th></th>
                        	<g:sortableColumn property="name" title="Name" />
                            <g:sortableColumn property="mean" title="Skill" style="width: 40px" />
                            <g:sortableColumn property="standardDeviation" title="&sigma;" style="width: 40px" />
                        	<g:sortableColumn property="avgScore" title="avg. Score" style="width: 70px" />
                        	<g:sortableColumn property="elo" title="ELO" style="width: 40px"/>
                   	        <g:sortableColumn property="matchesWon" title="Matches Won" />
                   	        <g:sortableColumn property="matchesLost" title="Matches Lost" />
                  	        <g:sortableColumn property="matchesDraw" title="Matches Draw" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${playerList}" status="i" var="player">
                    	<g:set var="nrOfMatches" value="${Math.max(player.totalMatches(), 1)}" />
                        <g:set var="rclass" value="${((player.standardDeviation ?: 10.0) > 4) ? 'rosa' : (i % 2) == 0 ? 'odd' : 'even'}"/>
                        <tr class="${rclass}">
                            <td>${i+1}</td>
                        	<td><g:link action="show" id="${player.id}">${player.name?.encodeAsHTML()}</g:link></td>
                         	<td>${String.format("%.0f",player.mean ?: 0.0)}</td>
                            <td>${String.format("%.0f",player.standardDeviation ?: 0.0)}</td>
                            <td>${String.format("%.2f",player.scoreAVG())}</td>
                            <td>${String.format("%.0f",player.elo  ?: 0.0)}</td>
                            <td>${String.format("%.0f",player.matchesWon*100.0/nrOfMatches)}% </td>
                            <td>${String.format("%.0f",player.matchesLost*100.0/nrOfMatches)}% </td>
                            <td>${String.format("%.0f",player.matchesDraw*100.0/nrOfMatches)}% </td>
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
