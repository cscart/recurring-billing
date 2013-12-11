{if $languages|sizeof > 1}
<div class="select-lang">
{if !"ULTIMATE:FREE"|fn_allowed_for}
    {include file="common/select_object.tpl" style="graphic" link_tpl="`$config.current_url`&selected_section=recurring_billing_orders"|fn_link_attach:"descr_sl=" items=$languages selected_id=$smarty.const.DESCR_SL key_name="name" suffix="content" display_icons=true target_id="content_recurring_billing"}
{/if}
</div>
{/if}

{if $item.update_for_all && $settings.Stores.default_state_update_for_all == 'not_active' && !$runtime.simple_ultimate}
    {assign var="disable_input" value=true}
{/if}

{assign var="statuses" value=$smarty.const.STATUSES_ORDER|fn_get_statuses}

{foreach from=$statuses key="key" item="status"}

<h4>{__("status")}: {$status.description}</h4>

<div class="control-group setting-wide">
    {assign var="rb_order_status_email_subject" value="rb_order_status_email_subject_`$status.status`"}
    <label for="rb_order_status_email_subject_{$status.status}" class="control-label">{__("email_subject")}{include file="common/tooltip.tpl" tooltip=__("rb_settings_orders_tooltip", ["[name]" => $rb_order_status_email_subject, "[link]" => fn_url('languages.manage?q=rb_order_status_email_')])}:</label>
    <div class="controls">
        <input id="rb_order_status_email_subject_{$status.status}" class="input-large" {if $disable_input}disabled="disabled"{/if} type="text" value="{fn_rb_settings_langvar($rb_order_status_email_subject, $smarty.const.DESCR_SL)}" name="additional_orders_settings[{$rb_order_status_email_subject}]">
        <div class="pull-right update-for-all">
            {include file="buttons/update_for_all.tpl" display=$item.update_for_all object_id=$item.object_id name="update_all_vendors[`$item.object_id`]" hide_element="rb_order_status_email_subject_`$status.status`"}
        </div>
    </div>
</div>

<div class="control-group setting-wide">
    {assign var="rb_order_status_email_header" value="rb_order_status_email_header_`$status.status`"}
    <label for="rb_order_status_email_header_{$status.status}" class="control-label">{__("email_header")}{include file="common/tooltip.tpl" tooltip=__("rb_settings_orders_tooltip", ["[name]" => $rb_order_status_email_header, "[link]" => fn_url('languages.manage?q=rb_order_status_email_')])}:</label>
    <div class="controls">
        <textarea id="rb_order_status_email_header_{$status.status}" class="input-large" {if $disable_input}disabled="disabled"{/if} rows="8" cols="55" name="additional_orders_settings[{$rb_order_status_email_header}]">{fn_rb_settings_langvar($rb_order_status_email_header, $smarty.const.DESCR_SL)}</textarea>
        <div class="pull-right update-for-all">
            {include file="buttons/update_for_all.tpl" display=$item.update_for_all object_id=$item.object_id name="update_all_vendors[`$item.object_id`]" hide_element="rb_order_status_email_header_`$status.status`"}
        </div>
    </div>
</div>

{/foreach}
