<div class="cm-reload-{$p_id}" id="recurring_plan_{$plan_item.plan_id}_update_{$p_id}">
{if $active_item && !$hide_plan_id}
    <input type="hidden" id="rb_plan_{$p_id}" name="product_data[{$p_id}][recurring_plan_id]" value="{$plan_item.plan_id}" />
{/if}
<input type="hidden" name="cart_id" value="{$subscription_object_id}" />
<input type="hidden" name="return_to" value="{$return_mode}" />

{if $plan_item.plan_id == 0}
    {assign var="plan_name" value=__("rb_buy_product_without_subscription")}
{else}
    {assign var="plan_name" value=$plan_item.name}
{/if}
<div class="subscription-option">{if $show_radio}<label for="recurring_plan_{$plan_item.plan_id}" class="option-items"><input type="radio" id="recurring_plan_{$plan_item.plan_id}" class="radio" onclick="fn_change_options('{$p_id}');" value="{$plan_item.plan_id}" name="recurring_plan_id"{if $active_item} checked="checked"{/if} /> {/if}<span>{$plan_name}</span>{if $show_radio}</label>{/if}</div>

{if $plan_item.plan_id != 0}

{if $smarty.capture.show_price_values}
    <div class="subscription-info">
        {if $plan_item.start_duration && $plan_item.base_price != $plan_item.last_base_price}
        <div class="control-group{if !$plan_item.base_price|floatval} hidden{/if}" id="line_start_recurring_price_{$p_id}_{$plan_item.plan_id}">
            <label>{__("rb_start_price")}:</label>
            {include file="common/price.tpl" value=$plan_item.base_price span_id="start_recurring_price_`$p_id`_`$plan_item.plan_id`" class="price"}
        </div>
        {/if}
        <div class="control-group{if !$plan_item.last_base_price|floatval} hidden{/if}" id="line_recurring_price_{$p_id}_{$plan_item.plan_id}">
            <label>{__("rb_price")}:</label>
            {include file="common/price.tpl" value=$plan_item.last_base_price span_id="recurring_price_`$p_id`_`$plan_item.plan_id`" class="price"}
        </div>
        {/if}

        {if $plan_item.description}
        <p>{$plan_item.description nofilter}</p>
        {/if}
        <div class="control-group">
            <label>{__("rb_recurring_period")}:</label>
            <span>{$plan_item.period|fn_get_recurring_period_name}{if $plan_item.period == "P"} - {$plan_item.by_period} {__("days")}{/if}</span>
        </div>

        {if $alt_duration && $alt_duration != $plan_item.duration}
            {assign var="plan_duration" value=$alt_duration}
        {else}
            {assign var="plan_duration" value=$plan_item.duration}
        {/if}

        {if $plan_item.allow_change_duration == "Y"}
        <div class="control-group">
            <label for="rb_plan_duration_{$plan_item.plan_id}_{$p_id}">{__("rb_duration")}:</label>
            <input id="rb_plan_duration_{$plan_item.plan_id}_{$p_id}" class="input-text-short cm-rb-duration{if !$active_item} disabled{/if}" size="5" type="text" name="product_data[{$p_id}][recurring_duration]" value="{$plan_duration}"{if !$active_item} disabled="disabled"{/if} />
        </div>
        {else}
        <div class="control-group">
            <label>{__("rb_duration")}:</label>
            <span>{$plan_duration}</span>
        </div>
        {/if}

        {if $plan_item.start_duration}
        <div class="control-group">
            <label>{__("rb_start_duration")}:</label>
            <span>{$plan_item.start_duration} {if $plan_item.start_duration_type == "D"}{__("days")}{else}{__("months")}{/if}</span>
        </div>
        {/if}
    </div>
{/if}
<!--recurring_plan_{$plan_item.plan_id}_update_{$p_id}--></div>