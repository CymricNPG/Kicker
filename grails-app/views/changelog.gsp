<html>
<head>
<title>Changelog for Kicker</title>
<meta name="layout" content="main" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
<div class="body">
<h1>Changelog</h1>
<h2>3.5</h2>
<ul>
    <li>upgraded to grails 3.0.11</li>
    <li>correct logout action added </li>
    <li>new goal statistics added</li>
</ul>
<h2>3.4</h2>
<ul>
	<li>upgraded to grails 3.0.9</li>
	<li>fixed elo graph </li>
	<li>removed id from matches and players tables </li>
	<li>players table sorted by elo </li>
	<li>fixed sorting of average score </li>
</ul>

<h2>3.3</h2>
<ul>
	<li>upgraded to grails 3.0.8</li>
</ul>

<h2>3.2</h2>
<ul>
	<li>upgraded to grails 3.0.4</li>
	<li>fixed elo calculation</li>
</ul>
<h2>3.1</h2>
<ul>
	<li>switched to some fancy select for players.</li>
	<li>changed the size of names to 1..12 characters </li>
	<li>moved to github</li>
</ul>
<h2>3.0</h2>
<ul>
	<li>upgraded to grails 3.0.2</li>
</ul>
<h2>2.7</h2>
<ul>
	<li>upgraded to grails 2.1</li>
	<li>render charts with the Google Visualization API</li>
	<li>changed database to h2</li>
</ul>
<h2>2.6</h2>

<ul>
	<li>moved changelog to extra page</li>
	<li>moved database configuration to an external file</li>
	<li>fixed the home-link</li>
</ul>

<h2>2.5</h2>

<ul>
	<li>upgraded to grails 1.3</li>
	<li>fixed some smaller bugs when not enough matches exists</li>
</ul>


<h2>2.4</h2>

<ul>
	<li>upgraded to grails 1.2</li>
</ul>


<h2>2.3</h2>

<ul>
	<li>upgraded to grails 1.0.4</li>
	<li>changed back to cvs</li>
</ul>


<h2>2.2</h2>

<ul>
	<li>serious bug found, if you have more than 9 players</li>
</ul>


<h2>2.1</h2>

<ul>
	<li>shorten surnames</li>
	<li>changed some font sizes</li>
	<li>added matches to player view</li>
</ul>


<h2>2.0</h2>

<ul>
	<li>Added match statistics</li>
	<li>New sourceforge release</li>
</ul>


<h2>1.4</h2>

<ul>
	<li>Changed domain class Game to Match (database has changed, a
	simple update from 1.3 to 1.4,2.0 or higher is not possible!)</li>
	<li>Renamed a lot of domain class attributes</li>
	<li>New logo</li>
	<li>New menu</li>
	<li>Logout, login and calculator icons added</li>
</ul>


<h2>1.3</h2>

<ul>
	<li>Sub-menu templates for game and player view added</li>
	<li>Help page for game, player and home view added</li>
</ul>

<h2>1.2</h2>

<ul>
	<li>Elo Visualization added to Player</li>
	<li>If player has now password, he can always log in</li>
	<li>Passwords are now encrypted</li>
	<li>Sorting of non-fields columns no possible (player list)</li>
</ul>

<h2>1.1</h2>

<ul>
	<li>Update to grails 1.0.1</li>
	<li>Added Eastwood Chart generation in Player section</li>
	<li>Number of games are only shown if user is logged in</li>
	<li>Password for each player added</li>
</ul>

<h2>1.0</h2>

<ul>
	<li>Sourceforge Version</li>
</ul>

<h2>0.5</h2>

<ul>
	<li>Bug in sorting fixed</li>
	<li>Edit of games added</li>
</ul>

<h2>0.4</h2>

<ul>
	<li>NullpointerException removed.</li>
	<li>Update to Grails 1.0</li>
	<li>player selection is remembered in the game create view</li>
	<li>RecalculateElo can only be called if you're logged in</li>
	<li>Sorting of games reversed.</li>
</ul>

<h2>0.3</h2>

<ul>
	<li>It's now possible to recalculate the "elo" and score. If you
	delete a game, ask the administrator to start recalculation.</li>
</ul>


<h2>todo</h2>

<ul>
	<li>Trends (have you improved in the last week?)</li>
	<li>Confiuration page (login enabled, min number of matches ...)</li>
	<li>i18n</li>
	<li>Tests</li>
	<li>Delete Users</li>
	<li>if not a number is entered as goals ... exception</li>
</ul>

<hr />
The application is open source and hosted on <A
	HREF="http://sourceforge.net/projects/kicker/"><IMG
	SRC="http://sourceforge.net/sflogo.php?group_id=9495&amp;type=1"
	NAME="Graphic2" ALT="SourceForge Logo" ALIGN=MIDDLE BORDER=0></A>.</div>
</body>
</html>