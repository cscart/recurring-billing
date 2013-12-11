{if $product.recurring_plans}
        {if $quick_view}
            <div class="subscription-products-button">
                {include file="buttons/button.tpl" but_href="products.view?product_id=`$product.product_id`" but_role="big" but_text=__("rb_edit_subscription")}
            </div>
        {else}
        	<div class="subscription-products-link">
				{include file="buttons/button.tpl" but_onclick="Tygh.$('#recurring_plans').click(); Tygh.$.scrollToElm(Tygh.$('#content_recurring_plans'));" but_role="text" but_text=__("rb_edit_subscription")}
        </div>
        {/if}
    <div class="clear"></div>
{/if}