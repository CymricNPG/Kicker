
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Match Help</title>
</head>
<body>
<g:render template="/match/match_menu" />
<p/>
<div class="body">
<table class="normal" width="800">
<tr><td>
<h1>Match Help</h1>
<g:if test="${flash.message}">
	<div class="message">${flash.message}</div>
</g:if>
<h2>Match List</h2>
The <span class="menuButton"><g:link class="list" action="list">Match List</g:link></span>
button shows all matches, starting with the newest match.
<h2>New Match</h2>
If you click on <span class="menuButton"><g:link class="create" action="create">New Match</g:link></span>
in the menu bar, you can create a new match. The form has multiple fields,
some of them have to be filled in, some are optional. It starts with the date field:<p />
<g:datePicker name='date'></g:datePicker><br />
This shows the current date and time. <br />
(Hint: Currently the date is not being used for ELO calculation.) 
<p>
Next you have to enter the teams. Currently Kicker supports only two
teams consisting of 1-2 players:<p/>
<table  class="normal" width="100">
	<tbody>
		<tr>
			<td valign='top' class='name' bgcolor='lightblue'><label
				for='teamOnePlayers'>Team 1 Players:</label> <br />
			(blue)</td>
			<td valign='top' bgcolor='lightblue'>
			<g:select name="gameTeamOnePlayers" from="${Player.listOrderByName()}"
				optionValue="name" optionKey="id" multiple="true" /></td>

			<td valign='top' class='name' bgcolor='lightpink'><label
				for='teamTwoPlayers'>Team 2 Players:</label> <br />
			(red)</td>
			<td valign='top' bgcolor='lightpink'>
			<g:select name="gameTeamTwoPlayers" from="${Player.listOrderByName()}"
				optionValue="name" optionKey="id" multiple="true" /></td>
		</tr>
	</tbody>
</table><p/>
The two teams have different colors: blue and red.
</p>
<p>
At the end you have to enter the match result. Here you have two choices: 
"Quick Result" or the exact "Result".<br/>
"Quick Result" is for people with poor memory, who can just type in how many games each side has won.<p />
<table class="normal"  width="100">
	<tbody>
		<tr>
			<th>Team&nbsp;1</th>
			<th></th>
			<th>Team&nbsp;2</th>
		</tr>
		<tr>
			<td bgcolor='lightblue'><input type="text" id='gamesTeamOne'
				name='gamesTeamOne' value="0" size="4" maxlength="2" /></td>
			<td>:</td>
			<td bgcolor='lightpink'><input type="text" id='gamesTeamTwo'
				name='gamesTeamTwo' value="0" size="4" maxlength="2" /></td>

		</tr>
	</tbody>
</table><p/>
The algorithm calculates the difference between the two sides... (see ELO ...)
</p>
<p>
The more sophisticated way to enter the match result is to enter the exact numbers of goals.<p />
<table class="normal"  width="100">
	<tbody>
		<tr>
			<th></th>
			<th>Team&nbsp;1</th>
			<th>Team&nbsp;2</th>
		</tr>
		<tr>
			<th>Game&nbsp;1</th>
			<td bgcolor='blue'>
			<input type="text" id='gameOneTeamOne' name='gameOneTeamOne'
				value="${game?.gameOneTeamOne}" size="4" maxlength="2" /></td>
			<td bgcolor='orange'>
			<input type="text" id='gameOneTeamTwo' name='gameOneTeamTwo'
				value="${game?.gameOneTeamTwo}" size="4" maxlength="2" /></td>
		</tr>

		<tr>
			<th>Game&nbsp;2</th>
			<td bgcolor='orange'>
			<input type="text" id='gameTwoTeamOne' name='gameTwoTeamOne'
				value="${game?.gameTwoTeamOne}" size="4" maxlength="2" /></td>
			<td bgcolor='blue'>
			<input type="text" id='gameTwoTeamTwo' name='gameTwoTeamTwo'
				value="${game?.gameTwoTeamTwo}" size="4" maxlength="2" /></td>

		</tr>

		<tr>
			<th>Game&nbsp;3</th>
			<td bgcolor='blue'>
			<input type="text" id='gameThreeTeamOne' name='gameThreeTeamOne'
				value="${game?.gameThreeTeamOne}" size="4" maxlength="2" /></td>
			<td bgcolor='orange'>
			<input type="text" id='gameThreeTeamTwo' name='gameThreeTeamTwo'
				value="${game?.gameThreeTeamTwo}" size="4" maxlength="2" /></td>
		</tr>
	</tbody>
</table><p/>
The most important point is that you have to play at least two games and must not play more 
than three games.
The team that wins two games wins the match. "Draw" (1:1, 2:2, ...) is not allowed as a result of a game.<br/>
According to the colors above, the teams have to change sides in every game. 
The first column shows the goals of team 1 (color blue), the second column is for team 2 (color red).			
</p>
<h2>Recalculate ELO</h2>
This menu button <span class="menuButton"><g:link class="calc" action="recalc">Recalculate ELO</g:link></span> appears only if you're logged in.<br/>
If you have deleted or edited a game, you must recalculate the ELO. This has to be done manually, because
the application checks all games and recalculates the ELO values for all players, which
is a time and memory consuming task.
<h2>Edit</h2>
This menu button  <span class="menuButton"><g:link class="edit" action="Edit">Edit</g:link></span>
appears only  if you're logged in.<br/>
If you have entered some wrong data before, you can change all values of a match. 
In the "Match List" you have to select the match and then click on the Button "Edit" in the lower left corner.
<h2>Delete</h2>
This menu button <span class="menuButton"><g:link class="delete" action="Delete">Delete</g:link></span>
appears only  if you're logged in.<br/>
You can also delete a match. This is done similar to "Edit".
</td></tr></table>
</div>
</body>
</html>
