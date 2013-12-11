<div class="subscription">
{include file="addons/recurring_billing/views/subscriptions/components/subscriptions_search_form.tpl"}

<form action="{""|fn_url}" method="post" name="subscriptions_list_form">

{include file="common/pagination.tpl"}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{if $search.sort_order == "asc"}
{assign var="sort_sign" value="<i class=\"icon-down-dir\"></i>"}
{else}
{assign var="sort_sign" value="<i class=\"icon-up-dir\"></i>"}
{/if}

{if !$config.tweaks.disable_dhtml}
    {assign var="ajax_class" value="cm-ajax"}
{/if}

<table class="table table-width">
<thead>
    <tr>
        <th><a class="{$ajax_class}" href="{"`$url_prefix``$c_url`&sort_by=subscription_id&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("id")}</a>{if $search.sort_by == "subscription_id"}{$sort_sign nofilter}{/if}</th>
        <th><a class="{$ajax_class}" href="{"`$url_prefix``$c_url`&sort_by=date&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("date")}</a>{if $search.sort_by == "date"}{$sort_sign nofilter}{/if}</th>
        <th><a class="{$ajax_class}" href="{"`$url_prefix``$c_url`&sort_by=start_price&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("start_price")}</a>{if $search.sort_by == "start_price"}{$sort_sign nofilter}{/if}</th>
        <th><a class="{$ajax_class}" href="{"`$url_prefix``$c_url`&sort_by=price&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("price")}</a>{if $search.sort_by == "price"}{$sort_sign nofilter}{/if}</th>
        <th><a class="{$ajax_class}" href="{"`$url_prefix``$c_url`&sort_by=duration&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("rb_duration_short")}</a>{if $search.sort_by == "duration"}{$sort_sign nofilter}{/if}</th>
        <th><a class="{$ajax_class}" href="{"`$url_prefix``$c_url`&sort_by=last_paid&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("last_order")}</a>{if $search.sort_by == "last_paid"}{$sort_sign nofilter}{/if}</th>
        <th>&nbsp;</th>
        <th style="width: 1%" class="right">
            <i id="on_st" title="{__("expand_collapse_list")}" class="icon-right-dir dir-list cm-combinations-subscriptions"></i><i id="off_st" title="{__("expand_collapse_list")}" class="icon-down-dir dir-list hidden cm-combinations-subscriptions"></i>{__("extra")}</th>
    </tr>
</thead>
{foreach from=$subscriptions item="sub" name="subscriptions"}
{cycle values=",table-row" assign="row_class_name"}
{include file="addons/recurring_billing/views/subscriptions/components/additional_data.tpl" data=$sub.product_ids assign="additional_data"}
<tr class="{$row_class_name}">
    <td><a href="{"subscriptions.view?subscription_id=`$sub.subscription_id`"|fn_url}"><strong>#{$sub.subscription_id}</strong></a></td>
    <td>{$sub.timestamp|date_format:$settings.Appearance.date_format}</td>
    <td>{include file="common/price.tpl" value=$sub.start_price}</td>
    <td class="right">{include file="common/price.tpl" value=$sub.price}</td>
    <td class="center">
        {if $sub.allow_change_duration == "Y"}
            <input type="text" name="update_duration[{$sub.subscription_id}]" value="{$sub.duration}" size="6" class="input-text-short" />
        {else}
            {$sub.duration}
        {/if}
    </td>
    <td>{$sub.last_timestamp|date_format:$settings.Appearance.date_format}</td>
    <td>
        {if $sub.allow_unsubscribe == "Y"}
            {assign var="need_update" value=true}
            <a href="{"subscriptions.unsubscribe?subscription_id=`$sub.subscription_id`"|fn_url}">{__("unsubscribe")}</a>
        {else}
            &nbsp;
        {/if}
    </td>
    <td class="right nowrap">
        {if $additional_data|trim}
            <a id="sw_products_{$smarty.foreach.subscriptions.iteration}" class="cm-combination-subscriptions"><i id="on_products_{$smarty.foreach.subscriptions.iteration}" title="{__("expand_collapse_list")}" class="icon-right-dir dir-list cm-combination-subscriptions"></i><i id="off_products_{$smarty.foreach.subscriptions.iteration}" title="{__("expand_collapse_list")}" class="icon-down-dir dir-list hidden cm-combination-subscriptions"></i>{__("extra")}</a>
        {else}
        &nbsp;
        {/if}
    </td>
</tr>
{if $additional_data|trim}
<tr id="products_{$smarty.foreach.subscriptions.iteration}" class="{$row_class_name} hidden">
    <td colspan="8">
    <div class="subscription-products">
        <div class="subscription-products-arrow"><span class="caret-info down"> <span class="caret-outer"></span><span class="caret-inner"></span></span></div>
        {if $additional_data|trim}
            {__("products")}: {$additional_data nofilter}
        {/if}
    </div>
    </td>
</tr>
{/if}
{foreachelse}
<tr>
    <td colspan="8"><p class="no-items">{__("no_data_found")}</p></td>
</tr>
{/foreach}
</table>

{include file="common/pagination.tpl"}

{if $need_update}
    <div class="buttons-container">
    {include file="buttons/button.tpl" but_name="dispatch[subscriptions.update]" but_text=__("update") but_role="action"}
    </div>
{/if}
</form>

{capture name="mainbox_title"}{__("rb_subscriptions")}{/capture}
</div>