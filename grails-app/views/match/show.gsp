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
            <tr class="prop">
                <th valign="top" class="name">Id:</th>
                <td valign="top" class="value">${match.id}</td>
            </tr>

            <tr class="prop">
                <th valign="top" class="name">Date:</th>
                <td valign="top" class="value">${match.date}</td>
            </tr>

            <tr class="prop">
                <th valign="top" class="name">Quality</th>
                <td valign="top" style="text-align: left;" class="value"> ${String.format("%.2f",match.matchQuality)}
                </td>
            </tr>
            <tr class="prop">
                <th valign="top" class="name">result</th>
                <td valign="top" style="text-align: left;" class="value"> ${match.result}</td>
            </tr>
            <tr>
                <td colspan="2">
                    <table>
                        <tr class="prop">
                            <th valign="top" style="text-align: left;">Game&nbsp;1</th>
                            <td valign="top" style="text-align: left;" class="value"> ${match.game1Team1}</td>
                            <td valign="top" style="text-align: left;" class="value"> ${match.game1Team2}</td>
                        </tr>
                        <tr class="prop">
                            <th valign="top" style="text-align: left;">Game&nbsp;2</th>
                            <td valign="top" style="text-align: left;" class="value"> ${match.game2Team1}</td>
                            <td valign="top" style="text-align: left;" class="value"> ${match.game2Team2}</td>
                        </tr>
                        <tr class="prop">
                            <th valign="top" style="text-align: left;">Game&nbsp;3</th>
                            <td valign="top" style="text-align: left;" class="value"> ${match.game3Team1}</td>
                            <td valign="top" style="text-align: left;" class="value"> ${match.game3Team2}</td>
                        </tr>
                        <tr class="prop">
                            <th valign="top" style="text-align: left;">Score</th>
                            <td valign="top" style="text-align: left;" class="value"> ${match.scoreTeam1}</td>
                            <td valign="top" style="text-align: left;" class="value"> ${match.scoreTeam2}</td>
                        </tr>
                        <tr class="prop">
                            <th>Players</th>
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                    <g:each var="t" in="${match.team1Players.sort{it.name}}">
                                        <li>
                                            <g:link controller="player" action="show" id="${t.id}">${t.name}</g:link>
                                        </li>
                                    </g:each>
                                </ul>
                            </td>
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
                    </table>
                </td>

            </tr>


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
