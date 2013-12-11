{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="manage_recurring_plans_form">

{include file="common/pagination.tpl"}

{if $recurring_plans}
<table width="100%" class="table table-middle">
<thead>
<tr>
    <th width="1%" class="left">
        {include file="common/check_items.tpl"}</th>
    <th width="60%">{__("title")}</th>
    <th width="20%">{__("rb_recurring_period")}</th>
    <th>&nbsp;</th>
    <th class="right" width="10%">{__("status")}</th>
</tr>
</thead>

{foreach from=$recurring_plans item="rec_plan"}
<tr class="cm-row-status-{$rec_plan.status|lower}">
    <td>
           <input type="checkbox" name="plan_ids[]" value="{$rec_plan.plan_id}" class="cm-item" /></td>
    <td class="row-status">
        <a href="{"recurring_plans.update?plan_id=`$rec_plan.plan_id`"|fn_url}">{$rec_plan.name}</a></td>
       <td class="row-status">
           {$rec_plan.period|fn_get_recurring_period_name}</td>
       <td>
        {capture name="tools_list"}
            <li>{btn type="list" text=__("edit") href="recurring_plans.update?plan_id=`$rec_plan.plan_id`"}</li>
            <li>{btn type="list" class="cm-confirm" text=__("delete") href="recurring_plans.delete?plan_id=`$rec_plan.plan_id`"}</li>
        {/capture}
        <div class="hidden-tools">
            {dropdown content=$smarty.capture.tools_list}
        </div>
       </td>
    <td>
        {include file="common/select_popup.tpl" id=$rec_plan.plan_id status=$rec_plan.status hidden="" popup_additional_class="pull-right" object_id_name="plan_id" table="recurring_plans"}
    </td>
</tr>
{/foreach}
</table>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl"}
</form>
{/capture}

{capture name="buttons"}
    {capture name="tools_list"}
        {if $recurring_plans}
            <li>{btn type="delete_selected" dispatch="dispatch[recurring_plans.m_delete]" form="manage_recurring_plans_form"}</li>
        {/if}
    {/capture}
    {dropdown content=$smarty.capture.tools_list}
{/capture}

{capture name="adv_buttons"}
    {btn type="add" title=__("add_plan") href="recurring_plans.add"}
{/capture}

{capture name="sidebar"}
    {capture name="content_sidebar"}
        <ul class="nav nav-list">
            <li><a href="{"addons.manage#grouprecurring_billing"|fn_url}"><i class="icon-cog"></i>{__("rb_recurring_billing_settings")}</a></li>
        </ul>
    {/capture}
    {include file="common/sidebox.tpl" content=$smarty.capture.content_sidebar title=__("settings")}
{/capture}

{include file="common/mainbox.tpl" title=__("rb_recurring_plans") content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons sidebar=$smarty.capture.sidebar}