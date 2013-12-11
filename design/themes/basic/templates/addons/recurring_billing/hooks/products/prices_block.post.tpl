{if $product.recurring_plans && !($runtime.controller == "products" && ($runtime.mode == "view" || $runtime.mode == "options"))}

{if $product.extra.recurring_plan_id}
    {assign var="_cur_plan_id" value=$product.extra.recurring_plan_id}
{else}
    {assign var="first_plan" value=$product.recurring_plans|reset}
    {assign var="_cur_plan_id" value=$first_plan.plan_id}
{/if}

<input type="hidden" id="rb_plan_{$obj_prefix}{$obj_id}" name="product_data[{$obj_id}][recurring_plan_id]" value="{$_cur_plan_id}" />

{/if}