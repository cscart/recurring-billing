{if $product.extra.recurring_plan_id && !($runtime.controller == "subscriptions" && $runtime.mode == "view")}
    <div class="product-list-field clearfix">

        <label>{__("rb_recurring_plan")}:</label>
        <span>{$product.extra.recurring_plan.name}</span>
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
{/if}