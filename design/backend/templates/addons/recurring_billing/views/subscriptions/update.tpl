{capture name="mainbox"}

{capture name="tabsbox"}
<div id="content_general">
<form action="{""|fn_url}" method="post" name="subscription_form" class="form-horizontal form-edit ">
<input type="hidden" name="subscription_id" value="{$subscription.subscription_id}" />
<input type="hidden" name="order_id" value="{$subscription.order_id}" />
<input type="hidden" name="selected_section" id="selected_section" value="{$smarty.request.selected_section}" />

    <div class="control-group">
        <label class="control-label">{__("rb_creation_date")}:</label>
        <div class="controls">
            <span class="shift-input">{$subscription.timestamp|date_format:$settings.Appearance.date_format}</span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="subs_status">{__("status")}:</label>
        <div class="controls">
        <select name="status" id="subs_status">
            <option value="A"{if $subscription.status == "A"} selected="selected"{/if}>{__("active")}</option>
            <option value="D"{if $subscription.status == "D"} selected="selected"{/if}>{__("disabled")}</option>
            <option value="U"{if $subscription.status == "U"} selected="selected"{/if}>{__("rb_unsubscribed")}</option>
            <option value="C"{if $subscription.status == "C"} selected="selected"{/if}>{__("completed")}</option>
        </select>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">{__("rb_recurring_plan")}:</label>
        <div class="controls">
            <span class="shift-input">
            <a href="{"recurring_plans.update?plan_id=`$subscription.plan_id`"|fn_url}">#{$subscription.plan_id}</a>
            </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">{__("order")}:</label>
        <div class="controls">
        <span class="shift-input">
            <a href="{"orders.details?order_id=`$subscription.order_id`"|fn_url}">#{$subscription.order_id}</a>
        </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">{__("end_date")}:</label>
        <div class="controls">
            <span class="shift-input">
            {$subscription.end_timestamp|date_format:$settings.Appearance.date_format}
            </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">{__("last_order")}:</label>
        <div class="controls">
            <span class="shift-input">
            {$subscription.last_timestamp|date_format:$settings.Appearance.date_format}
            </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">{__("rb_recurring_period")}:</label>
        <div class="controls">
            <span class="shift-input">
            {$subscription.plan_info.period|fn_get_recurring_period_name}{if $subscription.plan_info.period == "P"} - {$subscription.plan_info.by_period} {__("days")}{/if}
            </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">{__("customer")}:</label>
        <div class="controls">
            <span class="shift-input">
            <span>{$subscription.order_info.firstname}&nbsp;{$subscription.order_info.lastname}</span>, <a href="mailto:{$subscription.order_info.email|escape:url}">{$subscription.order_info.email}</a>
            </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">{__("payment_method")}:</label>
        <div class="controls">
            <span class="shift-input">
            {$subscription.order_info.payment_method.payment}&nbsp;{if $subscription.order_info.payment_method.description}({$subscription.order_info.payment_method.description}){/if}
            </span>
        </div>
    </div>

    {include file="common/subheader.tpl" title=__("shipping_information")}

    {foreach from=$subscription.order_info.shipping item="shipping" key="shipping_id" name="f_shipp"}
    <div class="control-group">
        <label class="control-label">{__("method")}:</label>
        <div class="controls">
            <span class="shift-input">
            {$shipping.shipping}
            </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="tracking_number">{__("tracking_number")}:</label>
    <div class="controls">
        <input id="tracking_number" type="text" class="input-text-medium" name="update_shipping[{$shipping_id}][tracking_number]" size="45" value="{$shipping.tracking_number}" />
    </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="carrier_key">{__("carrier")}:</label>
        <div class="controls">
        <select id="carrier_key" name="update_shipping[{$shipping_id}][carrier]">
            <option value="">--</option>
            <option value="USP" {if $shipping.carrier == "USP"}selected="selected"{/if}>{__("usps")}</option>
            <option value="UPS" {if $shipping.carrier == "UPS"}selected="selected"{/if}>{__("ups")}</option>
            <option value="FDX" {if $shipping.carrier == "FDX"}selected="selected"{/if}>{__("fedex")}</option>
            <option value="AUP" {if $shipping.carrier == "AUP"}selected="selected"{/if}>{__("australia_post")}</option>
            <option value="DHL" {if $shipping.carrier == "DHL" || $subscription.order_info.carrier == "ARB"}selected="selected"{/if}>{__("dhl")}</option>
            <option value="CHP" {if $shipping.carrier == "CHP"}selected="selected"{/if}>{__("chp")}</option>
        </select>
        </div>
    </div>
    {/foreach}

    <div class="control-group notify-customer">
        <div class="controls">
        <label for="notify_user" class="checkbox">
        <input type="checkbox" name="notify_user" id="notify_user" value="Y" />
        {__("notify_customer")}</label>
        </div>
    </div>
</form>
</div>

<div id="content_linked_products" class="hidden">
    <table width="100%" class="table table-middle">
    <thead>
    <tr>
        <th>{__("product")}</th>
        <th width="5%">{__("rb_price")}</th>
        <th width="5%">{__("quantity")}</th>
        {if $subscription.order_info.use_discount}
        <th width="5%">{__("discount")}</th>
        {/if}
        {if $subscription.order_info.taxes}
        <th width="5%">&nbsp;{__("tax")}</th>
        {/if}
        <th width="7%" class="right">&nbsp;{__("subtotal")}</th>
    </tr>
    </thead>
    {assign var="order_info" value=$subscription.order_info}
    {foreach from=$order_info.products item="oi" key="key"}
    {if !$oi.extra.parent && $oi.extra.recurring_plan_id == $subscription.plan_id && $oi.extra.recurring_duration == $subscription.orig_duration}
    {hook name="orders:items_list_row"}
    <tr>
        <td>
            {if !$oi.deleted_product}<a href="{"products.update?product_id=`$oi.product_id`"|fn_url}">{/if}{$oi.product nofilter}{if !$oi.deleted_product}</a>{/if}
            {hook name="orders:product_info"}
            {if $oi.product_code}</p>{__("sku")}:&nbsp;{$oi.product_code}</p>{/if}
            {/hook}
            {if $oi.product_options}<div class="options-info">{include file="common/options_info.tpl" product_options=$oi.product_options}</div>{/if}
        </td>
        <td class="nowrap">
            {if $oi.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$oi.base_price}{/if}</td>
        <td class="center">&nbsp;{$oi.amount}</td>
        {if $order_info.use_discount}
        <td class="nowrap">
            {if $oi.extra.discount|floatval}{include file="common/price.tpl" value=$oi.extra.discount}{else}-{/if}</td>
        {/if}
        {if $order_info.taxes}
        <td class="nowrap">
            {if $oi.tax_value|floatval}{include file="common/price.tpl" value=$oi.tax_value}{else}-{/if}</td>
        {/if}
        <td class="right">&nbsp;<span>{if $oi.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$oi.display_subtotal}{/if}</span></td>
    </tr>
    {/hook}
    {/if}
    {/foreach}
    </table>
</div>

<div id="content_paids" class="hidden">
    <script type="text/javascript">
    //<![CDATA[
    function fn_download_recurring_paid()
    {$ldelim}
        var $ = Tygh.$;
        $.ceAjax('request', '{"orders.manage?order_id=`$subscription.order_ids`"|fn_url:'A':'rel' nofilter}', {$ldelim}result_ids: 'pagination_contents,orders_total', callback: function() {$ldelim}$('#paids_tools').show();{$rdelim}{$rdelim});
        $('#paids').off('click', fn_download_recurring_paid);
    {$rdelim}

    {literal}
    Tygh.$(document).ready(function() {
        Tygh.$('#paids').on('click', fn_download_recurring_paid);
    });
    {/literal}
    //]]>
    </script>
    
    <form action="{""|fn_url}" method="post" target="_self" name="orders_list_form">

    <div id="pagination_contents"></div>
    <div id="orders_total" class="clear" align="right"></div>
    </form>
</div>
{/capture}

{capture name="buttons"}
    {include file="common/view_tools.tpl" url="subscriptions.update?subscription_id="}
    {include file="buttons/save_cancel.tpl" but_target_form="subscription_form" but_role="submit-link" but_name="dispatch[subscriptions.update]" save=true}
    {*include file="buttons/button.tpl" but_text=__("bulk_print") but_name="dispatch[orders.bulk_print]" but_meta="cm-process-items cm-new-window" but_role="button_main"*}
{/capture}

{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}

{/capture}
{assign var="title" value="{__("rb_viewing_subscription")}: #`$subscription.subscription_id`"}
{include file="common/mainbox.tpl" title=$title content=$smarty.capture.mainbox buttons=$smarty.capture.buttons}
