
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit Player</title>
    </head>
    <body>
        <g:render template="/player/player_menu" />
        <div class="body">
            <h1>Edit Player</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${player}">
            <div class="errors">
                <g:renderErrors bean="${player}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="player" method="post" >
                <input type="hidden" name="id" value="${player?.id}" />
                <div class="dialog">
                    <table class="normal" >
                        <tbody>
                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='name'>Name:</label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:player,field:'name','errors')}'>
                                    <input type="text" id='name' name='name' value="${fieldValue(bean:player,field:'name')}"/>
                                </td>
                            </tr>
                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='deactivated'>Deactivated:</label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:player,field:'deactivated','errors')}'>
                                    <g:checkBox name='deactivated' checked="${player?.deactivated}"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
