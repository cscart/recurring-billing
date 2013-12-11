{if $product.recurring_plans && !$product.recurring_plans.0 && !$details_page && $wishlist|fn_cart_is_empty}
    <{if $separate_buttons}div class="buttons-container"{else}span{/if}>
        {include file="buttons/button.tpl" but_text=__("subscribe") but_role="{if $but_role == "action"}action{else}text{/if}" but_href="products.view?product_id=`$product.product_id`"}
    </{if $separate_buttons}div{else}span{/if}>
{elseif $product.recurring_plans && $details_page && $subscription_object_id}
    <{if $separate_buttons}div class="buttons-container"{else}span{/if}>
        <input type="hidden" name="product_data[{$product.product_id}][cart_id]" value="{$subscription_object_id}" />
        <input type="hidden" name="product_data[{$product.product_id}][return_mode]" value="{$return_mode}" />
        {include file="buttons/save.tpl" but_name="dispatch[checkout.add]" but_meta="cm-no-ajax"}
    </{if $separate_buttons}div{else}span{/if}>
{/if}