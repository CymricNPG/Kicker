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
<tr><td><span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
</td><td> This page.</td></tr>
<tr><td><span class="menuButton"><g:link class="list" action="list" controller="player">Players</g:link></span>
</td><td> Player management, high score list, add/edit/delete players, change your password.</td></tr>
<tr><td><span class="menuButton"><g:link class="list" action="list" controller="match">Matches</g:link></span>
</td><td> Match Management, add/edit/delete/list matches</td></tr>
<tr><td><span class="menuButton"><g:link controller="info" class="info">Info</g:link></span>
</td><td> License Info, applications internals</td></tr>
<tr><td><span class="menuButton"><g:link action="logout" controller="player">Logout</g:link></span>
</td><td> Logout if your logged in.</td></tr>
<tr><td><span class="menuRight">User: ${session?.user?.name}</span>
</td><td> If you're logged in your player-name is displayed here.</td></tr>
<tr><td><span class="menuButton"><g:link action="login" controller="player">Login</g:link></span>
</td><td> This activates some functions in the detailed player or match view. Everyone starts with an empty password.</td></tr>
</table>
</p>
<hr/>
<h1>How to start?</h1>
Go to <g:link class="list" action="list" controller="player">Players</g:link> and create new players.
Go to <g:link class="list" action="list" controller="match">Matches</g:link> and add a new match.

<h1><g:link url="${resource(file:'changelog')}">Changelog</g:link></h1>

<h1>ELO</h1>
The ELO is based on the <a href="https://en.wikipedia.org/wiki/Elo_rating_system">Elo rating system</a> with some slight modifications.
For each match the ratings for both teams are calculated using the average from the elo rating of each team member. The match score based on the
team elo is displayed in the <g:link class="list" action="list" controller="match">Matches</g:link> table.  If the ELO is greater than
0.5, than team 1 was expected to win. If team 1 wins, it gets k*(1-ELO) points, if it loses, it loses k*ELO points. So if a strong team loses against a weak team, it loses more points than gaining in a winning game.

<hr/>
The application is open source and hosted on
<A HREF="https://github.com/CymricNPG/Kicker">GitHub</A>.
</div>
</body>
</html>