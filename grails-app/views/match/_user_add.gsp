
<script type="text/javascript" src="${resource(dir:'javascripts',file:'jquery-2.1.3.js')}"></script>
<script type="text/javascript" src="${resource(dir:'javascripts',file:'jquery.bsmselect.js')}"></script>
<link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'jquery.bsmselect.css')}" ></link>

 <script type="text/javascript">//<![CDATA[

    jQuery(function($) {

      $("#matchTeam1Players").bsmSelect({
        removeLabel: '<strong>X</strong>',
        containerClass: 'bsmContainer',                // Class for container that wraps this widget
        listClass: 'bsmList-custom',                   // Class for the list ($ol)
        listItemClass: 'bsmListItem-custom',           // Class for the <li> list items
        listItemLabelClass: 'bsmListItemLabel-custom', // Class for the label text that appears in list items
        removeClass: 'bsmListItemRemove-custom'        // Class given to the "remove" link
      });

      $("#matchTeam2Players").bsmSelect({
        removeLabel: '<strong>X</strong>',
        containerClass: 'bsmContainer',                // Class for container that wraps this widget
        listClass: 'bsmList-custom',                   // Class for the list ($ol)
        listItemClass: 'bsmListItem-custom',           // Class for the <li> list items
        listItemLabelClass: 'bsmListItemLabel-custom', // Class for the label text that appears in list items
        removeClass: 'bsmListItemRemove-custom'        // Class given to the "remove" link
      });
    });

  //]]></script>

