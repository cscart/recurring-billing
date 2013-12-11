{if $recurring_plan}
    {assign var="id" value=$recurring_plan.plan_id}
{else}
    {assign var="id" value=0}
{/if}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="recurring_plan_form" class="form-horizontal form-edit ">
<input type="hidden" name="plan_id" value="{$id}" />
<input type="hidden" name="selected_section" id="selected_section" value="{$smarty.request.selected_section}" />

<script type="text/javascript">
//<![CDATA[
    {literal}
    function fn_change_recurring_period(obj)
    {
        var day_inputs = Tygh.$('#pay_day_holder :input');
        var val = Tygh.$(obj).val();
        Tygh.$('#elm_recurring_plan_by_period').prop('disabled', true);
        Tygh.$('#elm_recurring_plan_by_period').parents('div.control-group:first').hide();
        if (val == 'P' && day_inputs.eq(0).prop('disabled')) {
            fn_switch_pay_day_input(day_inputs, 0);
            Tygh.$('#elm_recurring_plan_by_period').prop('disabled', false);
            Tygh.$('#elm_recurring_plan_by_period').parents('div.control-group:first').show();
        } else if (val == 'W' && day_inputs.eq(1).prop('disabled')) {
            fn_switch_pay_day_input(day_inputs, 1);
        } else if (val != 'W' && val != 'P' && day_inputs.eq(2).prop('disabled')) {
            fn_switch_pay_day_input(day_inputs, 2);
        }
    }

    function fn_switch_pay_day_input(inp, ind)
    {
        inp.prop('disabled', true).prop('id', '').hide();
        inp.eq(ind).prop('disabled', false).prop('id', 'pay_day').show();
    }

    function fn_toggle_recurring_price(obj, id)
    {
        if (Tygh.$(obj).val() != 'original') {
            Tygh.$('#' + id).show();
        } else {
            Tygh.$('#' + id).hide().val(0);
        }
    }
    {/literal}
//]]>
</script>

{capture name="tabsbox"}
<div id="content_general">
<fieldset>
    <div class="control-group">
        <label for="elm_recurring_plan_name" class="control-label cm-required">{__("title")}:</label>
        <div class="controls">
        <input type="text" name="recurring_plan[name]" id="elm_recurring_plan_name" value="{$recurring_plan.name}" size="50" class="input-large" />
        </div>
    </div>

    <div class="control-group">
        <label for="elm_recurring_plan_period" class="control-label cm-required">{__("rb_recurring_period")}</label>
        <div class="controls">
        <select id="elm_recurring_plan_period" name="recurring_plan[period]" onchange="fn_change_recurring_period(this);">
            {foreach from=$recurring_billing_data.periods key="value_type" item="name_lang_var"}
            <option value="{$value_type}" {if $recurring_plan.period == $value_type}selected="selected"{/if}>{__($name_lang_var)}</option>
            {/foreach}
        </select>
        </div>
    </div>

    <div class="control-group{if $recurring_plan.period != "P"} hidden{/if}">
        <label for="elm_recurring_plan_by_period" class="control-label cm-required">{__("rb_recurring_period_value")}:</label>
        <div class="controls">
            <input id="elm_recurring_plan_by_period" type="text" name="recurring_plan[by_period]" value="{$recurring_plan.by_period}" size="10" class="input-micro"{if $recurring_plan.period != "P"} disabled="disabled"{/if} />
        </div>
    </div>

    <div class="control-group" id="pay_day_holder">
        <label for="elm_recurring_plan_pay_day" class="cm-required control-label">{__("rb_pay_day")}:</label>
        <div class="controls">
        <input type="text" name="recurring_plan[pay_day]" value="{$recurring_plan.pay_day}" size="10" class="{if $recurring_plan.period != 'P'}hidden-input{/if} input-small" {if $recurring_plan.period == "P"}id="elm_recurring_plan_pay_day"{else}disabled="disabled"{/if} />
        <select class="input-small {if $recurring_plan.period != 'W'}hidden{/if}" name="recurring_plan[pay_day]" {if $recurring_plan.period == "W"}id="elm_recurring_plan_pay_day"{else}disabled="disabled"{/if}>
            {section name=$key loop="7" start="0" step="1"}
            {assign var="name_lang_var" value="weekday_abr_`$smarty.section.$key.index`"}
            <option value="{$smarty.section.$key.index}"{if $recurring_plan.pay_day == $smarty.section.$key.index} selected="selected"{/if}>{__($name_lang_var)}</option>
            {/section}
        </select>

        <select class="input-small {if $recurring_plan.period == 'W' || $recurring_plan.period == 'P'}hidden{/if}" name="recurring_plan[pay_day]" {if $recurring_plan.period == "W" || $recurring_plan.period == "P"}disabled="disabled"{else}id="elm_recurring_plan_pay_day"{/if}>
            {section name=$key loop="32" start="1" step="1"}
            <option value="{$smarty.section.$key.index}"{if $recurring_plan.pay_day == $smarty.section.$key.index} selected="selected"{/if}>{$smarty.section.$key.index}</option>
            {/section}
        </select>
        </div>
    </div>

    <div class="control-group">
        <label for="elm_recurring_plan_price" class="control-label cm-required">{__("rb_price")}:</label>
        <div class="controls">
        <select name="recurring_plan[price_type]" onchange="fn_toggle_recurring_price(this, 'elm_recurring_plan_price');">
            {foreach from=$recurring_billing_data.price item="val"}
            <option value="{$val}" {if $recurring_plan.price.type == $val}selected="selected"{/if}>{__($val)|lower}</option>
            {/foreach}
        </select>&nbsp;
        <input type="text" name="recurring_plan[price_value]" id="elm_recurring_plan_price" value="{$recurring_plan.price.value|default:0}" size="10" class="input-micro{if $recurring_plan.price.type == "original" || !$recurring_plan.price.type} hidden-input{/if}" />
        </div>
    </div>

    <div class="control-group">
        <label for="elm_recurring_plan_duration" class="control-label cm-required">{__("rb_duration")}:</label>
        <div class="controls">
        <input type="text" name="recurring_plan[duration]" id="elm_recurring_plan_duration" value="{$recurring_plan.duration}" size="10" />
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="elm_recurring_plan_start_price">{__("rb_start_price")}:</label>
        <div class="controls">
        <select name="recurring_plan[start_price_type]" onchange="fn_toggle_recurring_price(this, 'elm_recurring_plan_start_price');">
            {foreach from=$recurring_billing_data.price item="val"}
            <option value="{$val}"{if $recurring_plan.start_price.type == $val} selected="selected"{/if}>{__($val)|lower}</option>
            {/foreach}
        </select>&nbsp;
        <input type="text" name="recurring_plan[start_price_value]" id="elm_recurring_plan_start_price" value="{$recurring_plan.start_price.value}" size="10" class="input-micro {if $recurring_plan.start_price.type == "original" || !$recurring_plan.start_price.type} hidden-input{/if}" />
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="elm_recurring_plan_start_duration">{__("rb_start_duration")}:</label>
        <div class="controls">
        <input type="text" name="recurring_plan[start_duration]" id="elm_recurring_plan_start_duration" value="{$recurring_plan.start_duration}" size="10" class="input-micro" />
        <select name="recurring_plan[start_duration_type]">
            <option value="D"{if $recurring_plan.start_duration_type == "D"} selected="selected"{/if}>{__("days")}</option>
            <option value="M"{if $recurring_plan.start_duration_type == "M"} selected="selected"{/if}>{__("months")}</option>
        </select>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="elm_recurring_plan_note">{__("rb_note")}:</label>
        <div class="controls">
            <textarea name="recurring_plan[description]" id="elm_recurring_plan_note" cols="50" rows="4" class="cm-wysiwyg input-large">{$recurring_plan.description}</textarea>
        </div>
    </div>

    {include file="common/select_status.tpl" input_name="recurring_plan[status]" id="elm_recurring_plan_status" obj=$recurring_plan}

    <div class="control-group">
        <label class="control-label" for="elm_recurring_plan_allow_setup_duration">{__("rb_allow_setup_duration")}:</label>
        <div class="controls">
            <input type="hidden" name="recurring_plan[allow_change_duration]" value="N" />
            <input type="checkbox" name="recurring_plan[allow_change_duration]" id="elm_recurring_plan_allow_setup_duration"{if $recurring_plan.allow_change_duration == "Y"} checked="checked"{/if} value="Y" />
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="elm_recurring_plan_allow_unsubscribe">{__("rb_allow_unsubscribe")}:</label>
        <div class="controls">
            <input type="hidden" name="recurring_plan[allow_unsubscribe]" value="N" />
            <input type="checkbox" name="recurring_plan[allow_unsubscribe]" id="elm_recurring_plan_allow_unsubscribe"{if $recurring_plan.allow_unsubscribe == "Y"} checked="checked"{/if} value="Y" />
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="elm_recurring_plan_allow_free_buy">{__("rb_allow_buy_without_subscription")}:</label>
        <div class="controls">
            <input type="hidden" name="recurring_plan[allow_free_buy]" value="N" />
            <input type="checkbox" name="recurring_plan[allow_free_buy]" id="elm_recurring_plan_allow_free_buy"{if $recurring_plan.allow_free_buy == "Y"} checked="checked"{/if} value="Y" />
        </div>
    </div>
</fieldset>
</div>

<div id="content_linked_products" class="hidden">
    {include file="pickers/products/picker.tpl" input_name="recurring_plan[product_ids]" data_id="added_products" item_ids=$recurring_plan.product_ids type="links" placement="right"}
</div>
{/capture}
{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}
</form>

{capture name="buttons"}
    {include file="buttons/save_cancel.tpl" but_name="dispatch[recurring_plans.update]" but_role="submit-link" but_target_form="recurring_plan_form" save=$id}
{/capture}

{if !$id}
    {assign var="title" value=__("rb_new_plan")}
{else}
    {assign var="title" value="{__("rb_editing_plan")}: `$recurring_plan.name`"}
{/if}

{/capture}
{include file="common/mainbox.tpl" title=$title content=$smarty.capture.mainbox buttons=$smarty.capture.buttons select_languages=true}
