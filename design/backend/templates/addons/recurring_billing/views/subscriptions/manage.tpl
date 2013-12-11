{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="subscriptions_list_form">

{include file="common/pagination.tpl" save_current_page=true save_current_url=true}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{assign var="c_icon" value="<i class=\"exicon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"exicon-dummy\"></i>"}

{if $subscriptions}
<table width="100%" class="table table-middle">
<thead>
<tr>
    <th width="1%" class="left nowrap">
        {include file="common/check_items.tpl"}</th>
    <th class="nowrap" width="1%"><a class="cm-ajax" href="{"`$c_url`&sort_by=subscription_id&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("id")}{if $search.sort_by == "subscription_id"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    <th width="5%" class="nowrap"><a class="cm-ajax" href="{"`$c_url`&sort_by=order_id&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("order_id")}{if $search.sort_by == "order_id"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    <th class="nowrap" width="22%"><a class="cm-ajax" href="{"`$c_url`&sort_by=customer&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("customer")}{if $search.sort_by == "customer"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>/&nbsp;&nbsp;&nbsp;<a class="cm-ajax" href="{"`$c_url`&sort_by=email&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("email")}{if $search.sort_by == "email"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    <th class="nowrap"><a class="cm-ajax" href="{"`$c_url`&sort_by=date&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("date")}{if $search.sort_by == "date"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    <th class="nowrap"><a class="cm-ajax" href="{"`$c_url`&sort_by=start_price&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("start_price")}{if $search.sort_by == "start_price"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    <th class="nowrap"><a class="cm-ajax" href="{"`$c_url`&sort_by=price&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("rb_price")}{if $search.sort_by == "price"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    <th class="nowrap"><a class="cm-ajax" href="{"`$c_url`&sort_by=last_paid&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("last_order")}{if $search.sort_by == "last_paid"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    <th class="nowrap" width="8%">&nbsp;</th>
    <th width="10%" class="right"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
</tr>
</thead>
{foreach from=$subscriptions item="sub"}
<tr class="cm-row-status-{$sub.status|lower}">
    <td class="left row-status">
        <input type="checkbox" name="subscription_ids[]" value="{$sub.subscription_id}" class="cm-item" /></td>
    <td class="row-status">
        <a href="{"subscriptions.update?subscription_id=`$sub.subscription_id`"|fn_url}" class="underlined"><span>#{$sub.subscription_id}</span></a></td>
    <td class="row-status">
        <a href="{"orders.details?order_id=`$sub.order_id`"|fn_url}" class="underlined"><span>#{$sub.order_id}</span></a></td>
    <td class="row-status">{if $sub.user_id}<a href="{"profiles.update?user_id=`$sub.user_id`"|fn_url}">{/if}{$sub.lastname} {$sub.firstname}{if $sub.user_id}</a>{/if}<br><a href="mailto:{$sub.email|escape:url}" class="muted">{$sub.email}</a></td>
    <td class="nowrap row-status">
        {$sub.timestamp|date_format:$settings.Appearance.date_format}</td>
    <td class="row-status">
        {include file="common/price.tpl" value=$sub.start_price}</td>
    <td class="row-status">
        {include file="common/price.tpl" value=$sub.price}</td>
    <td class="row-status">
        {$sub.last_timestamp|date_format:$settings.Appearance.date_format}</td>
    <td class="center row-status">
        <div class="hidden-tools">
            {capture name="tools_list"}
                <li>{btn type="list" text=__("charge") href="subscriptions.charge?subscription_id=`$sub.subscription_id`"}</li>
                <li class="divider"></li>
                <li>{btn type="list" text=__("view") href="subscriptions.update?subscription_id=`$sub.subscription_id`"}</li>
                <li>{btn type="list" class="cm-confirm" text=__("delete") href="subscriptions.delete?subscription_id=`$sub.subscription_id`"}</li>
            {/capture}
            {dropdown content=$smarty.capture.tools_list}
        </div>
    </td>
    <td class="right nowrap">
        {include file="common/select_popup.tpl" id=$sub.subscription_id status=$sub.status items_status="recurring_billing"|fn_get_predefined_statuses update_controller="subscriptions" notify=true}
    </td>
</tr>
{/foreach}
</table>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{if $orders}
    {include file="common/table_tools.tpl" href="#subscriptions"}
{/if}

{include file="common/pagination.tpl"}
</form>
{/capture}

{capture name="sidebar"}
    {include file="common/saved_search.tpl" dispatch="subscriptions.manage" view_type="subscriptions"}
    {include file="addons/recurring_billing/views/subscriptions/components/subscriptions_search_form.tpl" dispatch="subscriptions.manage"}
{/capture}

{capture name="buttons"}
    {capture name="tools_list"}
        {if $subscriptions}
            <li>{btn type="delete_selected" dispatch="dispatch[subscriptions.m_delete]" form="subscriptions_list_form"}</li>
        {/if}
    {/capture}
    {dropdown content=$smarty.capture.tools_list}

    {if $subscriptions}
        {include file="buttons/button.tpl" but_text=__("process_selected") but_name="dispatch[subscriptions.bulk_charge]" but_meta="cm-confirm cm-process-items" but_role="submit-link" but_target_form="subscriptions_list_form"}
    {/if}
{/capture}


{include file="common/mainbox.tpl" title=__("rb_subscriptions") content=$smarty.capture.mainbox buttons=$smarty.capture.buttons sidebar=$smarty.capture.sidebar}