
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit a Match</title>
        <g:render template="/match/user_add" />
    </head>
    <body>
        <g:render template="/match/match_menu" />
        <div class="body">
            <h1>Edit a Match</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${match}">
            <div class="errors">
                <g:renderErrors bean="${match}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="match" method="post" >
                <input type="hidden" name="id" value="${match?.id}" />
                <g:render template="/match/match_edit"/>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
