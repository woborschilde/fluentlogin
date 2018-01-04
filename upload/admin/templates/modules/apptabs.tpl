{assign var="ifcase" value="class='active' style='font-weight: bold;'"}

<h4 style="margin-bottom: -10px;">{$appName}</h4><hr style="height: 3px; background-image: linear-gradient(to right, rgb(136, 136, 136), rgba(0, 0, 0, 0), rgba(0, 0, 0, 0));" />
<ul class="nav nav-tabs" style="margin-top: -6px; margin-bottom: -1px;">
    <li {if $ata == "general"}{$ifcase}{/if}><a href="appEdit.php?appID={$appID}" style="cursor: pointer;">General</a></li>
    <li {if $ata == "users"}{$ifcase}{/if}><a href="users.php?appID={$appID}" style="cursor: pointer;">Users</a></li>
    <li {if $ata == "groups"}{$ifcase}{/if}><a href="groups.php?appID={$appID}" style="cursor: pointer;">Groups</a></li>
    <li {if $ata == "fields"}{$ifcase}{/if}><a href="fields.php?appID={$appID}" style="cursor: pointer;">Fields</a></li>
    <li {if $ata == "permissions"}{$ifcase}{/if}><a href="permissions.php?appID={$appID}" style="cursor: pointer;">Permissions</a></li>
    {foreach from=$plugins_hook_apps_tabs item=k}
      {include file='../../../plugins/'|cat:$k|cat:'/admin/templates/hook_apps_tabs.tpl'}
    {/foreach}
</ul>
