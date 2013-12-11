{if $product.recurring_plans}

{include file="addons/recurring_billing/views/products/components/recurring_plans.tpl" hide_common_inputs=true}
{capture name="passed_to_buttons_content"}Y{/capture}

{/if}