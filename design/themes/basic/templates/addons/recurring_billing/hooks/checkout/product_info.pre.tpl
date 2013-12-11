{if $product.extra.recurring_plan_id}
    <div class="product-list-field clearfix">
        <label>{__("rb_recurring_plan")}:</label>
        {assign var="opt_combination" value=$product.selected_options|fn_get_options_combination}
        <span>{$product.extra.recurring_plan.name} (<a href="{"products.view?product_id=`$product.product_id`&cart_id=`$key`&combination=`$opt_combination`&return_to=`$runtime.mode`"|fn_url}">{__("rb_edit_subscription")}</a>)</span>
    </div>

    <div class="product-list-field clearfix">
        <label>{__("rb_recurring_period")}:</label>
        <span>{$product.extra.recurring_plan.period|fn_get_recurring_period_name}</span>{if $product.extra.recurring_plan.period == "P"} - {$product.extra.recurring_plan.by_period} {__("days")}{/if}
    </div>

    <div class="product-list-field clearfix">
        <label>{__("rb_duration")}:</label>
        <span>{$product.extra.recurring_duration}</span>
    </div>

    {if $product.extra.recurring_plan.start_duration}
    <div class="product-list-field clearfix">
        <label>{__("rb_start_duration")}:</label>
        <span>{$product.extra.recurring_plan.start_duration} {if $product.extra.recurring_plan.start_duration_type == "D"}{__("days")}{else}{__("months")}{/if}</span>
    </div>
    {/if}
{elseif $product.recurring_plans}
    {assign var="opt_combination" value=$product.selected_options|fn_get_options_combination}
    <p>{include file="buttons/button.tpl" but_text=__("rb_add_subscription") but_href="products.view?product_id=`$product.product_id`&cart_id=`$key`&combination=`$opt_combination`&return_to=`$runtime.mode`" but_role="text"}</p>
{/if}