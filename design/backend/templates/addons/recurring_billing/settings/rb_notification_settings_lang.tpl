{if $languages|sizeof > 1}
<div class="select-lang">
{if !"ULTIMATE:FREE"|fn_allowed_for}
    {include file="common/select_object.tpl" style="graphic" link_tpl="`$config.current_url`&selected_section=recurring_billing_rb_notification"|fn_link_attach:"descr_sl=" items=$languages selected_id=$smarty.const.DESCR_SL key_name="name" suffix="notification" display_icons=true target_id="content_recurring_billing"}
{/if}
</div>
{/if}
