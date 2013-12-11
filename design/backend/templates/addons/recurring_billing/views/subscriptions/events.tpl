{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="subscriptions_list_form">
<div class="items-container" id="subscriptions_list">

{if $recurring_billing_data.events}
<table class="table table-middle">
<thead>
    <tr>
        <th width="1%">
            {if $recurring_billing_data.events}
            {include file="common/check_items.tpl"}
            {/if}
        </th>
    </tr>
</thead>  
{foreach from=$recurring_billing_data.events item="event_name" key="key"}
    {if $recurring_events.$key}
        <tr>
            <td colspan="5"><strong>{__($event_name)}</strong></td>
        </tr>
        {foreach from=$recurring_events.$key item="subs_id"}
            {assign var="subs_data" value=$subs_id|fn_get_recurring_subscription_info}
            {include file="common/price.tpl" value=$subs_data.price assign="subs_price"}
            {assign var="order_link" value="orders.details?order_id=`$subs_data.order_id`"|fn_url}
            {assign var="_details" value="{__("customer")}: <span>`$subs_data.firstname` `$subs_data.lastname`</span> | {__("rb_price")}: <span>`$subs_price`</span> | {__("order")}: <a class=\"link\" href=\"`$order_link`\">#`$subs_data.order_id`</a>"}
            {assign var="_text" value="{__("rb_subscription")} #`$subs_id`"}

            {capture name="tool_items"}
                <a class="icon-refresh cm-tooltip" href="{"subscriptions.process_event?subscription_id=`$subs_id`&type=`$key`"|fn_url}" title="{__("process")}"></a>
            {/capture}
            
            {include file="common/object_group.tpl"
                id="`$key`_`$subs_id`"
                text=$_text
                details=$_details
                act="default"
                checkbox_name="process_subscriptions[`$key`][]"
                checkbox_value=$subs_id
                checked=true
                not_clickable="true"
                main_link="subscriptions.update?subscription_id=`$subs_id`"
                no_table=true
                tool_items=$smarty.capture.tool_items
                nostatus=true}
        {/foreach}
    {/if}
{/foreach}
</table>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}
<!--subscriptions_list--></div>

{capture name="buttons"}
{if $recurring_billing_data.events}
    {include file="buttons/button.tpl" but_text=__("rb_process_selected_events") but_name="dispatch[subscriptions.process_events]" but_meta="cm-confirm cm-process-items" but_role="submit-link" but_target_form="subscriptions_list_form"}
{/if}
{/capture}

</form>

{/capture}
{include file="common/mainbox.tpl" title=__("rb_subscription_events") content=$smarty.capture.mainbox buttons=$smarty.capture.buttons}