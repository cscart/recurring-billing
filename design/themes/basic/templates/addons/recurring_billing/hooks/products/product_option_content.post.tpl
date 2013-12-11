{if $product.recurring_plans && !$wishlist|fn_cart_is_empty && $wishlist.products.$key.extra.recurring_plan}
    {include file="addons/recurring_billing/views/products/components/recurring_plan.tpl" plan_item=$wishlist.products.$key.extra.recurring_plan show_radio=false p_id=$key alt_duration=$wishlist.products.$key.extra.recurring_duration active_item=true hide_plan_id=true}
{/if}