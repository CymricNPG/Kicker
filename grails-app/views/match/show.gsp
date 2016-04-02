<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Show a Match</title>
</head>
<body>
<g:render template="/match/match_menu"/>
<div class="body">
    <h1>Show a Match</h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table class="normal">
            <tbody>

            <tr class="prop">
                <td valign="top" class="name">Id:</td>
                <td valign="top" class="value">${match.id}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Date:</td>
                <td valign="top" class="value">${match.date}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Results:</td>
                <td valign="top" style="text-align: left;" class="value"></td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">elo</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.elo}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Quality</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.matchQuality}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">game1Team1</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.game1Team1}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">game1Team2</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.game1Team2}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">game2Team1</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.game2Team1}</td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">game2Team2</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.game2Team2}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">game3Team1</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.game3Team1}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">game3Team2</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.game3Team2}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">result</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.result}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">scoreTeam1</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.scoreTeam1}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">scoreTeam2</td>
                <td valign="top" style="text-align: left;" class="value"> ${match.scoreTeam2}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Team 1 Players:</td>
                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each var="t" in="${match.team1Players.sort{it.name}}">
                            <li>
                                <g:link controller="player" action="show" id="${t.id}">${t.name}</g:link>
                            </li>
                        </g:each>
                    </ul>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Team 2 Players:</td>
                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each var="t" in="${match.team2Players.sort{it.name}}">
                            <li>
                                <g:link controller="player" action="show" id="${t.id}">${t.name}</g:link>
                            </li>
                        </g:each>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="buttons">
        <g:form controller="match">
            <input type="hidden" name="id" value="${match?.id}"/>
            <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');"
                                                 value="Delete"/></span>
        </g:form>
    </div>
</div>
</body>
</html>
