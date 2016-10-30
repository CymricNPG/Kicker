<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Show Player</title>
    <gvisualization:apiImport/>
</head>
<body>
<g:render template="/player/player_menu"/>
<div class="body">
    <h1>Show Player</h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:set var="nrOfMatches"
           value="${Math.max(player.matchesWon+player.matchesLost+player.matchesDraw,1)}"/>
    <div class="dialog">
        <table class="normal">
            <tbody>

            <tr class="prop">
                <td valign="top" class="name">Id:</td>
                <td valign="top" class="value">${player.id}</td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">Name:</td>
                <td valign="top" class="value">${player.name}</td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">Average Score:</td>
                <td valign="top" class="value">${player.scoreAVG()}</td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">Total Matches:</td>
                <td valign="top" class="value">${player.totalMatches()}</td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">Matches Draw:</td>
                <td valign="top" class="value">${String.format("%.0f",player.matchesDraw/nrOfMatches*100)}%</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Matches Lost:</td>
                <td valign="top" class="value">${String.format("%.0f",player.matchesLost/nrOfMatches*100)}%</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Matches Won:</td>
                <td valign="top" class="value">${String.format("%.0f",player.matchesWon/nrOfMatches*100)}%</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Score:</td>
                <td valign="top" class="value">${player.score}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Skill Mean:</td>
                <td valign="top" class="value">${player.mean}</td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">Skill standard deviation:</td>
                <td valign="top" class="value">${player.standardDeviation}</td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">Deactivated:</td>
                <td valign="top" class="value">${player.deactivated}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <p/>
    <div id="ELOChart">
<!--    <gvisualization:lineCoreChart elementId="ELOChart" width="${600}" height="${125}"
                                  columns="${[['number', 'Game'], ['number', 'ELO']] }" colors="${['76A4FB'] }"
                              title="ELO History" data="${elos}"/>
                                  -->
    </div>


    <div class="buttons">
        <g:form controller="player">
            <input type="hidden" name="id" value="${player?.id}"/>
            <g:if
                    test="${session?.user}">
                <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
            </g:if>
            <g:if
                    test="${session?.user}">
		<span class="button"><g:actionSubmit class="delete"
                                             onclick="return confirm('Are you sure?');" value="Delete"/></span>
            </g:if>
        </g:form>
    </div>

    <p/>
    <g:render template="/match/match_list"/>
</div>
</body>
</html>
