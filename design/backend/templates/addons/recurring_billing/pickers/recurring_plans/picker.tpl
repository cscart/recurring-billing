{math equation="rand()" assign="rnd"}
{assign var="data_id" value="`$data_id`_`$rnd`"}
{assign var="view_mode" value=$view_mode|default:"mixed"}

{script src="js/tygh/picker.js"}

{if $item_ids && !$item_ids|is_array}
    {assign var="item_ids" value=","|explode:$item_ids}
{/if}

{if $view_mode != "button"}
    <input id="r{$data_id}_ids" type="hidden" name="{$input_name}" value="{if $item_ids}{","|implode:$item_ids}{/if}" />
    
    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="table">
    <tr>
        <th width="100%">{__("name")}</th>
        <th>&nbsp;</th>
    </tr>
    <tbody id="{$data_id}"{if !$item_ids} class="hidden"{/if}>
    {include file="addons/recurring_billing/pickers/recurring_plans/js.tpl" recurring_plan_id="`$ldelim`recurring_plan_id`$rdelim`" holder=$data_id clone=true hide_delete_button=$hide_delete_button}
    {if $item_ids}
    {foreach from=$item_ids item="p_id"}
        {include file="addons/recurring_billing/pickers/recurring_plans/js.tpl" recurring_plan_id=$p_id holder=$data_id hide_delete_button=$hide_delete_button}
    {/foreach}
    {/if}
    </tbody>
    <tbody id="{$data_id}_no_item"{if $item_ids} class="hidden"{/if}>
    <tr class="no-items">
        <td colspan="2"><p>{$no_item_text|default:__("no_items")}</p></td>
    </tr>
    </tbody>
    </table>
{/if}

{if $view_mode != "list"}

    {if $extra_var}
        {assign var="extra_var" value=$extra_var|escape:url}
    {/if}

    {if !$no_container}<div class="buttons-container">{/if}{if $picker_view}[{/if}
        {include file="buttons/button.tpl" but_id="opener_picker_`$data_id`" but_href="recurring_plans.picker?display=`$display`&picker_for=`$picker_for`&extra=`$extra_var`&checkbox_name=`$checkbox_name`&aoc=`$aoc`&data_id=`$data_id`"|fn_url but_text=$but_text|default:__("rb_add_recurring_plans") but_role="add" but_target_id="content_`$data_id`" but_meta="cm-dialog-opener cm-tooltip" title=__("rb_usergroup_plan")}
    {if $picker_view}]{/if}{if !$no_container}</div>{/if}

    <div class="hidden" id="content_{$data_id}" title="{$but_text|default:__("rb_add_recurring_plans")}">
    </div>
{/if}