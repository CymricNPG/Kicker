<h1>Matches</h1>
<div class="list">
    <table class="normal">
        <thead>
        <tr>
            <g:sortableColumn property="date" title="Date" />
            <th>Team 1</th>
            <th>Team 2</th>
            <th>Game 1</th>
            <th>Game 2</th>
            <th>Game 3</th>
            <g:sortableColumn property="matchQuality" title="Quality" />
            <g:sortableColumn property="elo" title="ELO" />
        </tr>
        </thead>
        <tbody>
        <g:each in="${matchList}" status="i" var="match">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link controller="match" action="show" id="${match.id}">${match.date?.encodeAsHTML()}</g:link></td>
                <td class="${match.win(1)}">
                    <g:each in="${match.team1Players.sort { it.name }}" var="playerX">
                        <g:if test="${playerX.id == player?.id}">
                            <div class="user">
                                <g:link controller="player" action="show" id="${playerX.id}"> ${playerX.name} </g:link>
                            </div>
                        </g:if>
                        <g:else>
                            <div class="${match.win(1)}">
                                <g:link controller="player" action="show" id="${playerX.id}"> ${playerX.name} </g:link>
                            </div>
                        </g:else>
                    </g:each>
                </td>
                <td class="${match.win(2)}"><g:each in="${match.team2Players.sort{it.name}}" var="playerX">
                    <g:if test="${playerX.id == player?.id}">
                        <div class="user">
                            <g:link controller="player" action="show" id="${playerX.id}"> ${playerX.name} </g:link>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="${match.win(2)}">
                            <g:link controller="player" action="show" id="${playerX.id}"> ${playerX.name} </g:link>
                        </div>
                    </g:else>
                </g:each></td>
                <td>${match.game1Team1}:${match.game1Team2}</td>
                <td>${match.game2Team1}:${match.game2Team2}</td>
                <td>${match.game3Team1}:${match.game3Team2}</td>
                <td>${String.format("%.2f",match.matchQuality)}</td>
                <td>${String.format("%.2f",match.elo)}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<div class="paginateButtons"><g:paginate total="${maxMatches}" id="${player?.id}" />
</div>