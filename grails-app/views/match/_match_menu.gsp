<div class="nav">    
    <span class="menuButton"><g:link class="list" action="list">Match List</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">New Match</g:link></span>
    <span class="menuButton"><g:link class="info" action="statistics">Statistics</g:link></span>
    <g:if test="${session?.user}">
		<span class="menuButton"><g:link class="calc" action="recalc">Recalculate Skill</g:link></span>
	</g:if>
	<span class="menuButton">
		<g:link  class="help" action="help">Help</g:link>
	</span>
</div>