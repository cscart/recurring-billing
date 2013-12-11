{if $recurring_plan_id == "0"}
    {assign var="recurring_plan" value=$default_name}
{else}
    {assign var="recurring_plan" value=$recurring_plan_id|fn_get_recurring_plan_name|default:"`$ldelim`recurring_plan`$rdelim`"}
{/if}

<tr {if !$clone}id="{$holder}_{$recurring_plan_id}" {/if}class="cm-js-item{if $clone} cm-clone hidden{/if}">
    <td><a href="{"recurring_plans.update?plan_id=`$recurring_plan_id`"|fn_url}">{$recurring_plan}</a></td>
    <td>{if !$hide_delete_button && !$view_only}<a onclick="Tygh.$.cePicker('delete_js_item', '{$holder}', '{$recurring_plan_id}', 'r'); return false;"><i class="icon-trash"></i></a>{else}&nbsp;{/if}</td>
</tr>