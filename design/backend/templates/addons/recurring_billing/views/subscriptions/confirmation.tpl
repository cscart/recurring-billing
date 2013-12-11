{capture name="mainbox"}

<p>{__("text_confirmation_page_header")}</p>

{if $subscriptions}
<form action="{""|fn_url}" method="post" name="confirm_deletion">
<input type="hidden" name="redirect_url" value="{$redirect_url}" />
<input type="hidden" name="confirmed" value="Y" />
{foreach from=$order_ids item="value"}
<input type="hidden" name="order_ids[]" value="{$value}" />
{/foreach}
{foreach from=$subscriptions item="value" key="key"}
<p>{__("rb_subscription")} <a href="{"subscriptions.update?subscription_id=`$key`"|fn_url}">#{$key}</a> {__("rb_will_be_deleted_with_order")} <a href="{"orders.details?order_id=`$value`"|fn_url}">#{$value}</a></p>
{/foreach}

<p>{__("text_are_you_sure_to_proceed")}</p>

<div class="buttons-container">    
    {include file="buttons/button.tpl" but_text=__("yes") but_name="dispatch[orders.delete_orders]"}
    {include file="buttons/button.tpl" but_text=__("no") but_meta="cm-back-link"}
</div>

</form>
{/if}
{/capture}
{include file="common/mainbox.tpl" title=__("confirmation_dialog") content=$smarty.capture.mainbox}