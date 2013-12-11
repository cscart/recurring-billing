<div class="subscription">
{capture name="tabsbox"}
    <div id="content_general">
        <form action="{""|fn_url}" method="post" name="subscription_form">
        <input type="hidden" name="subscription_id" value="{$subscription.subscription_id}" />
        {include file="common/subheader.tpl" title=__("summary")}    
        <div class="orders-summary-wrap">
            <table>
                <tbody>
                    <tr>
                        <td>{__("rb_creation_date")}</td>
                        <td style="width: 57%">{$subscription.timestamp|date_format:$settings.Appearance.date_format}</td>
                    </tr>
                    <tr>
                        <td>{__("order_id")}</td>
                        <td style="width: 57%"><a href="{"orders.details?order_id=`$subscription.order_id`"|fn_url}">{$subscription.order_id}</a></td>
                    </tr>
                    <tr>
                        <td>{__("end_date")}</td>
                        <td style="width: 57%">{$subscription.end_timestamp|date_format:$settings.Appearance.date_format}</td>
                    </tr>
                    <tr>
                        <td>{__("last_order")}</td>
                        <td style="width: 57%">{$subscription.last_timestamp|date_format:$settings.Appearance.date_format}</td>
                    </tr>
                    <tr>
                        <td>{__("rb_recurring_period")}</td>
                        <td style="width: 57%">{$subscription.plan_info.period|fn_get_recurring_period_name}{if $subscription.plan_info.period == "P"} - {$subscription.plan_info.by_period} {__("days")}{/if}</td>
                    </tr>
                    <tr>
                        <td>{__("payment_method")}</td>
                        <td style="width: 57%">{$subscription.order_info.payment_method.payment}&nbsp;{if $subscription.order_info.payment_method.description}({$subscription.order_info.payment_method.description}){/if}</td>
                    </tr>
                    {if $subscription.plan_info.allow_change_duration == "Y"}
                    <tr class="last">
                        <td>{__("rb_duration_short")}:</td>
                        <td style="width: 57%"><input id="rb_duration" type="text" name="update_duration[{$subscription.subscription_id}]" value="{$subscription.duration}" size="6" class="input-text-short" /></td>
                    </tr>
                    {/if}
                </tbody>
            </table>
        </div>
        <div class="clear"></div>
        <div class="buttons-container">
            {assign var="update_action" value="action"}
            {if $subscription_pay_order_id}
                {include file="buttons/button.tpl" but_href="orders.details?order_id=`$subscription_pay_order_id`" but_text=__("rb_pay") but_role="action"}&nbsp;
                {assign var="update_action" value="text"}
            {/if}
            {if $subscription.plan_info.allow_change_duration == "Y"}
                {include file="buttons/button.tpl" but_name="dispatch[subscriptions.update]" but_text=__("update")}&nbsp;
            {/if}
            {if $subscription.plan_info.allow_unsubscribe == "Y"}
                <div class="float-right">
                {include file="buttons/button.tpl" but_name="dispatch[subscriptions.unsubscribe]" but_text=__("unsubscribe")}
                </div>
            {/if}
        </div>
        </form>
    </div>

    <div id="content_linked_products">
        <table class="table product-list table-width">
        <thead>
        <tr>
            <th>{__("product")}</th>
            <th style="width: 5%">{__("price")}</th>
            <th style="width: 5%">{__("quantity")}</th>
            {if $subscription.order_info.use_discount}
            <th style="width: 5%">{__("discount")}</th>
            {/if}
            {if $subscription.order_info.taxes}
            <th style="width: 5%">&nbsp;{__("tax")}</th>
            {/if}
            <th style="width: 7%" class="right">&nbsp;{__("subtotal")}</th>
        </tr>
        </thead>
        {assign var="order_info" value=$subscription.order_info}
        {foreach from=$order_info.products item="product" key="key"}
        {if !$product.extra.parent && $product.extra.recurring_plan_id == $subscription.plan_id && $product.extra.recurring_duration == $subscription.orig_duration}
        {hook name="orders:items_list_row"}
        <tr {cycle values="class=\"table-row\", " name="class_cycle"}>
            <td>
                {if !$product.deleted_product && !$product.shared_product}<a href="{"products.view?product_id=`$product.product_id`"|fn_url}" class="product-title">{/if}{$product.product nofilter}{if !$product.deleted_product && !$product.shared_product}</a>{/if}
                {hook name="orders:product_info"}
                {if $product.product_code}<p>{__("sku")}:&nbsp;{$product.product_code}</p>{/if}
                {/hook}
                {if $product.product_options}<div class="options-info">{include file="common/options_info.tpl" product_options=$product.product_options}</div>{/if}
            </td>
            <td class="nowrap">
                {if $product.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$product.base_price}{/if}</td>
            <td class="center">&nbsp;{$product.amount}</td>
            {if $order_info.use_discount}
            <td class="nowrap">
                {if $product.extra.discount|floatval}{include file="common/price.tpl" value=$product.extra.discount}{else}-{/if}</td>
            {/if}
            {if $order_info.taxes}
            <td class="nowrap">
                {if $product.tax_value|floatval}{include file="common/price.tpl" value=$product.tax_value}{else}-{/if}</td>
            {/if}
            <td class="right">&nbsp;<strong>{if $product.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$product.display_subtotal}{/if}</strong></td>
        </tr>
        {/hook}
        {/if}
        {/foreach}
        </table>
    </div>

    <div id="content_paids" data-ca-tab-target-id="pagination_contents">
        <div id="pagination_contents"></div>
    </div>
{/capture}
{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section}

{capture name="mainbox_title"}{__("rb_subscription")} #{$subscription.subscription_id}{/capture}
</div>
