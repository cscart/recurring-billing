{include file="common/letter_header.tpl"}

{__("dear")} {$subscription_info.firstname},<br /><br />

{$header}<br /><br />

{__("rb_subscription")} <a href="{"subscriptions.view?subscription_id=`$subscription_info.subscription_id`"|fn_url:'C':'http'}">#{$subscription_info.subscription_id}</a>

{include file="common/letter_footer.tpl"}