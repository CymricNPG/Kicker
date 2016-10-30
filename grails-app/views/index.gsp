<html>
<head>
<title>Welcome to Kicker</title>
<meta name="layout" content="main" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
<div class="body">
<h1>Welcome to Kicker</h1>
Kicker is a hobby foosball management application. You can manage your players and the matches.
<h1>Help</h1>
<p>In the main menu bar you have the following buttons:</p>
<p>
<table class="normal" border="1">
<tr><td><span class="menuButton"><a class="home" href="${createLink(uri:'/index')}">Home</a></span>
</td><td> This page.</td></tr>
<tr><td><span class="menuButton"><g:link class="list" action="list" controller="player">Players</g:link></span>
</td><td> Player management, high score list, add/edit/delete players</td></tr>
<tr><td><span class="menuButton"><g:link class="list" action="list" controller="match">Matches</g:link></span>
</td><td> Match Management, add/edit/delete/list matches</td></tr>
<tr><td><span class="menuButton"><g:link controller="info" class="info">Info</g:link></span>
</td><td> License Info, applications internals</td></tr>
<tr><td><span class="menuButton"><g:link action="logout" controller="player">Logout</g:link></span>
</td><td> Logout if your logged in as admin.</td></tr>
<tr><td><span class="menuButton"><g:link action="admin" controller="player">Admin</g:link></span>
</td><td> This activates some functions in the player or match view.</td></tr>
</table>
</p>
<hr/>
<h1>How to start?</h1>
Go to <g:link class="list" action="list" controller="player">Players</g:link> and create new players.
Go to <g:link class="list" action="list" controller="match">Matches</g:link> and add a new match.

<h1><g:link url="${createLink(uri:'/changelog')}">Changelog</g:link></h1>

<hr/>
The application is open source and hosted on
<A HREF="https://github.com/CymricNPG/Kicker">GitHub</A>.
</div>
</body>
</html>