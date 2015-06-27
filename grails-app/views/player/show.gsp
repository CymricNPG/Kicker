
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Show Player</title>
<gvisualization:apiImport/>
</head>
<body>
<g:render template="/player/player_menu" />
<div class="body">
<h1>Show Player</h1>
<g:if test="${flash.message}">
	<div class="message">${flash.message}</div>
</g:if> <g:set var="nrOfMatches"
	value="${Math.max(player.matchesWon+player.matchesLost+player.matchesDraw,1)}" />
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
			<td valign="top" class="name">Matches Draw:</td>
			<g:if
				test="${session?.user?.name && session?.user?.id?.equals(player?.id)}">
				<td valign="top" class="value">${player.matchesDraw}</td>
			</g:if>
			<g:else>
				<td valign="top" class="value">${String.format("%.0f",player.matchesDraw/nrOfMatches*100)}%</td>
			</g:else>

		</tr>

		<tr class="prop">
			<td valign="top" class="name">Matches Lost:</td>
			<g:if
				test="${session?.user?.name && session?.user?.id?.equals(player?.id)}">
				<td valign="top" class="value">${player.matchesLost}</td>
			</g:if>
			<g:else>
				<td valign="top" class="value">${String.format("%.0f",player.matchesLost/nrOfMatches*100)}%</td>
			</g:else>

		</tr>

		<tr class="prop">
			<td valign="top" class="name">Matches Won:</td>
			<g:if
				test="${session?.user?.name && session?.user?.id?.equals(player?.id)}">
				<td valign="top" class="value">${player.matchesWon}</td>
			</g:if>
			<g:else>
				<td valign="top" class="value">${String.format("%.0f",player.matchesWon/nrOfMatches*100)}%</td>
			</g:else>

		</tr>


		<tr class="prop">
			<td valign="top" class="name">Score:</td>

			<td valign="top" class="value">${player.score}</td>

		</tr>

	</tbody>
</table>
</div>
<p />
<gvisualization:lineCoreChart elementId="ELOChart" width="${600}" height="${125}" columns="${[['number', 'Game'], ['number', 'ELO']] }" colors="${['76A4FB'] }"
							  title="ELO History" data="${elos}"/>
<div id="ELOChart"></div>


	 
<div class="buttons"><g:form controller="player">
	<input type="hidden" name="id" value="${player?.id}" />
	<g:if
		test="${session?.user?.name && session?.user?.id?.equals(player?.id)}">
		<span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
	</g:if>
	<g:if
		test="${session?.user?.name && session?.user?.id?.equals(player?.id)}">
		<span class="button"><g:actionSubmit class="delete"
			onclick="return confirm('Are you sure?');" value="Delete" /></span>
	</g:if>
</g:form></div>

<p />
<h1>Matches</h1>
<div class="list">
<table class="normal">
	<thead>
		<tr>
			<g:sortableColumn property="id" title="Id" />
			<g:sortableColumn property="date" title="Date" />
			<th>Team 1</th>
			<th>Team 2</th>
			<th>Game 1</th>
			<th>Game 2</th>
			<th>Game 3</th>
			<th>Result</th>
			<g:sortableColumn property="elo" title="ELO" />
		</tr>
	</thead>
	<tbody>
		<g:each in="${matchList}" status="i" var="match">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

				<td><g:link controller="match" action="show" id="${match.id}">${match.id?.encodeAsHTML()}</g:link></td>

				<td>${match.date?.encodeAsHTML()}</td>
				<td class="${match.win(1)}">
				<g:each in="${match.team1Players}" var="playerX">	
					<g:if test="${playerX.id == player.id}">	
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
				<td class="${match.win(2)}"><g:each in="${match.team2Players}"
					var="playerX">				
					<g:if test="${playerX.id == player.id}">	
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
				<td>${match.result}</td>
				<td>${String.format("%.3f",match.elo)}</td>
			</tr>
		</g:each>
	</tbody>
</table>
</div>
<div class="paginateButtons"><g:paginate total="${maxMatches}" id="${player.id}" />
</div>


</div>
</body>
</html>
