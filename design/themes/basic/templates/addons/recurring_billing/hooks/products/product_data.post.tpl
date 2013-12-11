{if $runtime.controller == "products" && $runtime.mode == "options"}
    {include file="addons/recurring_billing/views/products/components/recurring_plans.tpl" obj_id=$obj_id}
{/if}