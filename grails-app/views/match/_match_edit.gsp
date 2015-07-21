<div class="dialog">
	<table  class="normal" border="0">
		<tbody>
			<tr class='prop'>
				<td valign='top' class='name'><label for='date'>Date:</label></td>
				<td valign='top' class='value ${hasErrors(bean:match,field:'date','errors')}' ><g:datePicker
					name='date' value="${match?.date}"></g:datePicker></td>
			</tr>
			<tr class='prop'>
				<td valign='top' class='name'><label for='teams'>Teams:</label>
				</td>
				<td valign='top'>
				<table  class="normal" width="100">
					<tbody>
						<tr>
							<td valign='top' class='name' bgcolor='lightblue'><label
								for='team1Players'>Team 1 Players:</label> <br />
							(Startcolor blue)</td>
							<td valign='top' bgcolor='lightblue'
								class='${hasErrors(bean:match,field:'team1Players','errors')}'>

							<g:select name="matchTeam1Players" from="${Player.listOrderByName()}"
								optionValue="name" optionKey="id" multiple="true"
								value="${match?.team1Players?.id}" /></td>

							<td valign='top' class='name' bgcolor='lightpink'><label
								for='team2Players'>Team 2 Players:</label> <br />
							(Startcolor red)</td>
							<td valign='top' bgcolor='lightpink'
								class='${hasErrors(bean:match,field:'team2Players','errors')}'>
							<g:select name="matchTeam2Players" from="${Player.listOrderByName()}"
								optionValue="name" optionKey="id" multiple="true"
								value="${match?.team2Players?.id}" /></td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
			<tr class='prop'>
				<td valign='top' class='name'><label for='quickresults'>Quick
				Result (games won):<br>
				<br>
				(Use this only, if you don't<br>
				remember the exact goals) </label></td>
				<td valign='top'>
				<table  class="normal" width="100">
					<tbody>
						<tr>
							<th>Team&nbsp;1</th>
							<th></th>
							<th>Team&nbsp;2</th>
						</tr>
						<tr>
							<td bgcolor='lightblue'><input type="text" id='gamesTeam1Won'
								name='gamesTeam1Won' value="0" size="4" maxlength="2" /></td>
							<td>:</td>
							<td bgcolor='lightpink'><input type="text" id='gamesTeam2Won'
								name='gamesTeam2Won' value="0" size="4" maxlength="2" /></td>

						</tr>
					</tbody>
				</table>

				</td>
			</tr>
			<tr class='prop'>
				<td valign='top' class='name'><label for='results'>Result:</label>
				</td>
				<td valign='top'>
				<table  class="normal" width="100">
					<tbody>
						<tr>
							<th></th>
							<th bgcolor='lightblue'>Team&nbsp;1</th>
							<th bgcolor='lightpink'>Team&nbsp;2</th>
						</tr>
						<tr>
							<th>Game&nbsp;1</th>
							<td bgcolor='lightblue'
								class='value ${hasErrors(bean:game,field:'game1Team1','errors')}'>
							<input type="text" id='game1Team1' name='game1Team1'
								value="${match?.game1Team1}" size="4" maxlength="2" /></td>
							<td bgcolor='lightpink'
								class='value ${hasErrors(bean:game,field:'game1Team2','errors')}'>
							<input type="text" id='game1Team2' name='game1Team2'
								value="${match?.game1Team2}" size="4" maxlength="2" /></td>
						</tr>

						<tr>
							<th>Game&nbsp;2</th>
							<td bgcolor='lightblue'
								class='value ${hasErrors(bean:game,field:'game2Team1','errors')}'>
							<input type="text" id='game2Team1' name='game2Team1'
								value="${match?.game2Team1}" size="4" maxlength="2" /></td>
							<td bgcolor='lightpink'
								class='value ${hasErrors(bean:game,field:'game2Team2','errors')}'>
							<input type="text" id='game2Team2' name='game2Team2'
								value="${match?.game2Team2}" size="4" maxlength="2" /></td>

						</tr>

						<tr>
							<th>Game&nbsp;3</th>
							<td bgcolor='lightblue'
								class='value ${hasErrors(bean:game,field:'game3Team1','errors')}'>
							<input type="text" id='game3Team1' name='game3Team1'
								value="${match?.game3Team1}" size="4" maxlength="2" /></td>
							<td bgcolor='lightpink'
								class='value ${hasErrors(bean:game,field:'game3Team2','errors')}'>
							<input type="text" id='game3Team2' name='game3Team2'
								value="${match?.game3Team2}" size="4" maxlength="2" /></td>
						</tr>

					</tbody>
				</table>
				</td>
			</tr>
		</tbody>
	</table>
</div>