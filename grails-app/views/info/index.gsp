<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Kicker Info Page</title>
</head>
<body>
<div class="body">
<h1>License</h1>
Kicker Copyright (C) 2008 <a href="mailto:c@npg.net">Roland Spatzenegger</a>
<br/>
This program comes with ABSOLUTELY NO WARRANTY;
<a href="http://www.gnu.org/licenses/gpl-3.0.html"> SHOW </a>
<br/>
This is free software, and you are welcome to redistribute it under
certain conditions;
<a href="http://www.gnu.org/licenses/gpl-3.0.html"> SHOW </a>
<br/>
The application is hosted on
<A HREF="https://github.com/CymricNPG/Kicker">GitHub</A>.
<h1>Application Info</h1>
This application uses:
<ul>
<li><a href="http://grails.codehaus.org/">
<img width="140px" height="42px" src="${resource(dir:'images',file:'grails_logo.jpg')}"align="middle" alt="Grails" BORDER="0"/>
</a> </li>
<li> <a href="https://developers.google.com/chart/interactive/docs/index">Google Visualization API</a>.</li>
<li> <a href="https://github.com/vicb/bsmSelect"> BSM Select </a></li>
</ul>
<h2>Grails Info</h2>
If you find a bug, please include the following information with your bug-report.
<ul>
<g:each in="${grailsApplication.metadata}" var="data">
	<li>Number ${data}</li>
</g:each>
</ul>
<h2>Grails Controller:</h2>
<div class="dialog" style="margin-left: 20px; width: 60%;">
<ul>
	<g:each var="c" in="${grailsApplication.controllerClasses}">
		<li class="controller"><g:link
			controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
	</g:each>
</ul>
</div>
</div>
</body>
</html>