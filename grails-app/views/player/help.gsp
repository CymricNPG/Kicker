
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Player Help</title>
</head>
<body>
<g:render template="/player/player_menu" />
<div class="body">
<p/>
<table class="normal" width="800">
	<tr>
		<td>
		<h1>Player Help</h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<h2>Player List</h2>
		The <span class="menuButton"><g:link class="list" action="list">Player List</g:link></span>
		button shows all players. You can sort the table by different columns.
		Click on the name to get more information about the player. Players with a &sigma; greater than 4 are marked in red.
		<h2>New Player</h2>
		If you click on <span class="menuButton"><g:link class="create"
			action="create">New Player</g:link></span> in the menu bar you can create a
		new player. Currently everyone can create a new player. The form has
		only one field:<p/>
		<table class="normal">
			<tbody>

				<tr class='prop'>
					<td valign='top' class='name'><label for='name'>Name:</label>
					</td>
					<td valign='top' class='value ${hasErrors(bean:player,field:'name','errors')}'>
					<input type="text" id='name' name='name'
						value="${fieldValue(bean:player,field:'name')}" /></td>
				</tr>

			</tbody>
		</table><p/>
		Here you can enter the name of the player. If you click on the <span
			class="menuButton"><g:link class="save" action="Create">Create</g:link></span>
		Button, the new player will be created.

		<h2>Edit</h2>
		The menu button <span class="menuButton"><g:link class="edit"
			action="Edit">Edit</g:link></span> appears in <b>your</b> detailed player
		view only if you're  in admin mode.<br />
		Here you can change your name.
		<h2>Delete</h2>
		This menu button <span class="menuButton"><g:link
			class="delete" action="Delete">Delete</g:link></span> appears in <b>your</b>
		detailed player view only if you're  in admin mode.<br />
		You can delete your account.
</div>
</td>
</tr>
</table>
</body>
</html>
