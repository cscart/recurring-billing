{** block-description:rb_subscription **}

{if $product.recurring_plans && !$smarty.capture.passed_to_buttons_content}

{include file="addons/recurring_billing/views/products/components/recurring_plans.tpl" hide_common_inputs=false}

{/if}