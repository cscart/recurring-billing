<div class="control-group setting-wide">
    <label for="rb_subscription_changing_email_subject" class="control-label">{__("email_subject")}:</label>
    <div class="controls">
    	<input id="rb_subscription_changing_email_subject" class="input-large" type="text" value="{fn_rb_settings_langvar("rb_subscription_changing_email_subject", $smarty.const.DESCR_SL)}" name="additional_notification_settings[rb_subscription_changing_email_subject]">
    </div>
</div>

<div class="control-group setting-wide">
    <label for="rb_subscription_changing_email_header" class="control-label">{__("email_header")}:</label>
    <div class="controls">
    	<textarea id="rb_subscription_changing_email_header" class="input-large" rows="8" cols="55" name="additional_notification_settings[rb_subscription_changing_email_header]">{fn_rb_settings_langvar("rb_subscription_changing_email_header", $smarty.const.DESCR_SL)}</textarea>
    </div>
</div>
