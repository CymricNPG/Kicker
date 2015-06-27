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
<tr><td><span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
</td><td> This page.</td></tr>
<tr><td><span class="menuButton"><g:link class="list" action="list" controller="player">Players</g:link></span>
</td><td> Player management, high score list, add/edit/delete players, change your password.</td></tr>
<tr><td><span class="menuButton"><g:link class="list" action="list" controller="match">Matches</g:link></span>
</td><td> Match Management, add/edit/delete/list matches</td></tr>
<tr><td><span class="menuButton"><g:link controller="info">Info</g:link></span>
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
<h1><g:link url="${createLinkTo(file:'changelog.gsp')}">Changelog</g:link></h1>

<hr/>
The application is open source and hosted on 
<A HREF="http://sourceforge.net/projects/kicker/"><IMG SRC="http://sourceforge.net/sflogo.php?group_id=9495&amp;type=1" NAME="Graphic2" ALT="SourceForge Logo" ALIGN=MIDDLE BORDER=0></A>. 
</div>
</body>
</html>