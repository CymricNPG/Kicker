
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Create a Match</title>
</head>
<body>
<g:render template="/match/match_menu" />
<div class="body">
<h1>Create a Match</h1>
<g:if test="${flash.message}">
	<div class="message">${flash.message}</div>
</g:if> <g:hasErrors bean="${match}">
	<div class="errors"><g:renderErrors bean="${match}" as="list" />
	</div>
</g:hasErrors> <g:form action="save" method="post">
	<g:render template="/match/match_edit" />
	<div class="buttons"><span class="button"><input
		class="save" type="submit" value="Create"></input></span></div>
</g:form></div>
</body>
</html>
