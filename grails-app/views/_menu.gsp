<table class="menu" border="0"
	cellpadding="0" cellspacing="0" >
	<tbody>
		<tr class="menu">
		<td style="height: 3px;"></td>
			<td style="height: 3px;"></td>
			<td style=" height: 3px;"></td>
			<td style="width: 90px; height: 3px;"><img
				style="width: 90px; height: 3px;" alt="line"
				src="${resource(dir:'images',file:'line_above.png')}"></td>
			<td colspan="6"  style=" height: 3px;"></td>
		</tr>
		<tr class="menu">
			<td class="menusmall" >
				<img style="width: 40px; height: 57px;" alt="x" src="${ resource(dir : 'images', file : 'start.png')}"></td>
			<td
				style="width: 90px; height: 47px;background-image: url(${ resource(dir : 'images', file : 'kicker_logo_line.png')})">
			<img style="width: 90px; height: 47px;"
				src="${resource(dir:'images',file:'kicker_logo4_small.png')}"
				align="middle" alt="Kicker" /></td>
			<td
				style="height: 57px; width: 10px; background-image: url(${ resource(dir : 'images', file : 'kicker_logo_line.png')})">
			<img style="width: 10px; height: 57px;" alt="x"
				src="${resource(dir:'images',file:'left_line.png')}"></td>
			<td style="width: 90px; height: 47px;background-image: url(${ resource(dir : 'images', file : 'kicker_logo_line.png')})"><span class="menuButton"><a class="home"
				href="${createLink(uri:'/index')}">Home</a></span></td>
			<td style="width: 90px; height: 47px;background-image: url(${ resource(dir : 'images', file : 'kicker_logo_line.png')})"><span class="menuButton"><g:link class="list"
				action="list" controller="player">Players</g:link></span></td>
			<td style="width: 90px; height: 47px;background-image: url(${ resource(dir : 'images', file : 'kicker_logo_line.png')})"><span class="menuButton"><g:link class="list"
				action="list" controller="match">Matches</g:link></span></td>
			<td style="width: 90px; height: 47px;background-image: url(${ resource(dir : 'images', file : 'kicker_logo_line.png')})"><span class="menuButton"><g:link class="info"
				controller="info">Info</g:link></span></td>
			<td style="width: 90px; height: 47px;background-image: url(${ resource(dir : 'images', file : 'kicker_logo_line.png')})">
			<g:if test="${session?.user}">
				<span class="menuButton"><g:link action="logout" controller="player" class="leave">Logout</g:link></span>
			</g:if>
			<g:else>
				<span class="menuButton"><g:link action="admin"	controller="player" class="login">Admin</g:link></span>
			</g:else></td>
			<td class="menusmall">
			<img style="width: 40px; height: 57px;" alt="x" src="${ resource(dir : 'images', file : 'finish.png')}"></td>
		</tr>
		<tr class="menu">
		<td style="height: 3px;"></td>
			<td style="width: 90px;"><img style="width: 90px; height: 3px;" alt="x"
			src="${resource(dir:'images',file:'line_below.png')}"></td>
			<td colspan="9"  style=" height: 3px;"></td>
		</tr>
	</tbody>
</table>

