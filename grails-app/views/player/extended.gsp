<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Player List</title>
    </head>
    <body>
        <g:render template="/player/player_menu" />
        <div class="body">
            <h1>Extended Player Info</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="normal">
                    <thead>
                        <tr>
                        	<g:sortableColumn property="name" title="Name" />
                        	<g:sortableColumn property="elo" title="ELO" style="width: 50px" />
                        	<g:sortableColumn property="goals" title="Goals per Round" style="width: 140px" />
                        	<g:sortableColumn property="diffs" title="Goals diff p. R." style="width: 140px" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${playerList}" status="i" var="player">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        	<td><g:link action="show" id="${player.id}">${player.name?.encodeAsHTML()}</g:link></td>
                        	<td>${String.format("%.0f",player.elo)}</td>
                        	<td>${String.format("%.2f",goalsRatio[player.id])}</td>
                        	<td>${String.format("%.2f",goalsDiff[player.id])}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
