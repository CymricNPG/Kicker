<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Statistics</title>
</head>
<body>
<g:render template="/match/match_menu"/>
<div class="body">
    <h1>Statistics</h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <h1>Winner side</h1>
    The numbers show the probability to win when starting with the given
    side:
    <p/>
    <table class="normal">
        <tr>
            <th>Blue</th>
            <th>Red</th>
        </tr>
        <tr>
            <td>${String.format("%.0f",blue)}%</td>
            <td>${String.format("%.0f",red)}%</td>
        </tr>
    </table>
    <h2>Best Partner</h2>
    This table shows how successful a certain combination of players was (in
    at least ${minMatches} matches).
    <p/>
    <table class="normal">
        <tr>
            <td colspan="2"> worst</td>
            <td colspan="18"></td>
            <td colspan="1" align="right"> best</td>
        </tr>
        <tr>
            <g:each in="${[-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10]}" status="i" var="pcell">
                <td class="color${pcell}">${pcell}</td>
            </g:each>
        </tr>
    </table>
    <p/>
    <div class="list">
        <table class="normal">
            <thead>
            <tr>
                <th>Name</th>
                <g:each in="${players}" status="i" var="player">
                    <th>
                        <g:link controller="player" action="show" id="${player}"> ${Player.get(player)?.shortName()}
                        </g:link>
                    </th>
                </g:each>
                <th>Name</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${partnerArray}" status="x" var="pline">
                <tr>
                    <td><b>
                        <g:link controller="player" action="show"
                                id="${players[x]}">
                            ${Player.get(players[x])?.shortName()}
                        </g:link>
                    </b></td>
                    <g:each in="${pline}" status="y" var="pcell">
                        <g:if test="${pcell || pcell == 0}">
                            <g:set var="back" value="color${pcell}"/>
                        </g:if>
                        <g:else>
                            <g:set var="back" value="${((x+y) % 2) == 0 && x<=y ? 'odd' : 'even'}"/>
                        </g:else>
                        <td class="${back}">
                            <g:if test="${x<y}">
                                ${pcell}
                            </g:if>
                        </td>
                    </g:each>
                    <td><b>
                        <g:link controller="player" action="show"
                                id="${players[x]}">
                            ${Player.get(players[x])?.shortName()}
                        </g:link>
                    </b></td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
    <p/>
    <table class="normal">
        <tr>
            <td>
                <h1>The 5 most successful teams</h1>
                (at least ${minMatches} matches)
                <p/>
                <g:set var="keys" value="${partnersScore.keySet().sort {partnersScore[it]} }"/>
                <table class="normal">
                    <g:each in="${keys.reverse()}" status="i" var="key">
                        <g:if test="${partnersScore[key].toInteger()>0 && 5 > i}">
                            <tr>
                                <th>
                                    <g:set var="pids" value="${key.tokenize(':')}"/>
                                    <g:link controller="player" action="show" id="${pids[0]}">
                                        ${Player.get(pids[0]).name}
                                    </g:link>
                                </th>
                                <th>
                                    <g:link controller="player" action="show" id="${pids[1]}">
                                        ${Player.get(pids[1]).name}
                                    </g:link>
                                </th>
                                <td>${String.format("%.1f",partnersScore[key])}</td>
                            </tr>
                        </g:if>
                    </g:each>
                </table>
            </td>
            <td>
                <h1>The 5 most unsuccessful teams</h1>
                (at least ${minMatches} matches)
                <p/>
                <g:set var="keys"
                       value="${partnersScore.keySet().sort {partnersScore[it]} }"/>
                <table class="normal">
                    <g:each in="${keys}" status="i" var="key">
                        <g:if test="${0>partnersScore[key] && 5 > i}">
                            <tr>
                                <th>
                                    <g:set var="pids" value="${key.tokenize(':')}"/>
                                    <g:link
                                            controller="player" action="show" id="${pids[0]}">
                                        ${Player.get(pids[0]).name}
                                    </g:link>
                                </th>
                                <th>
                                    <g:link controller="player" action="show" id="${pids[1]}">
                                        ${Player.get(pids[1]).name}
                                    </g:link>
                                </th>
                                <td>${String.format("%.1f",partnersScore[key])}</td>
                            </tr>
                        </g:if>
                    </g:each>
                </table>
            </td>
        </tr>
    </table>
    <table class="normal">
        <tr>
            <td>
                <h1> Heros</h1>
                <p/>
                <table class="normal">
                    <g:each in="${heroes.keySet()}" var="player">
                        <tr>
                            <th>
                                <g:link controller="player" action="show" id="${player.id}">
                                    ${player.name}<p/>
                                    <g:each in="${heroes[player]}" var="match">
                                        <g:link controller="match" action="show" id="${match.id}">
                                            ${match.date}
                                        </g:link>
                                    </g:each>
                                </g:link>
                            </th>
                        </tr>
                    </g:each>
                </table>
                <table class="normal">
                </table>
            </td>
            <td>
                <h1> Losers</h1>
                Lost a game with 0 goals.
                <p/>
                <table class="normal">
                    <g:each in="${losers.keySet()}" var="player">
                        <tr>
                            <th>
                                <g:link controller="player" action="show" id="${player.id}">
                                    ${player.name}<p/>
                                    <g:each in="${losers[player]}" var="match">
                                        <g:link controller="match" action="show" id="${match.id}">
                                            ${match.date}
                                        </g:link>
                                    </g:each>
                                </g:link>
                            </th>
                        </tr>
                    </g:each>
                </table>
                <table class="normal">
                </table>
            </td>
        </tr>
    </table>

</div>

</body>
</html>
