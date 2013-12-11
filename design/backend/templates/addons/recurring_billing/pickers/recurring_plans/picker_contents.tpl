{if !$smarty.request.extra}
<script type="text/javascript">
//<![CDATA[
(function(_, $) {
    _.tr('text_items_added', '{__("text_items_added")|escape:"javascript"}');

    $.ceEvent('on', 'ce.formpost_recurring_plans_form', function(frm, elm) {
        var recurring_plans = {};

        if ($('input.cm-item:checked', frm).length > 0) {
            $('input.cm-item:checked', frm).each( function() {
                var id = $(this).val();
                recurring_plans[id] = $('#recurring_plan_' + id).text();
            });

            {literal}
            $.cePicker('add_js_item', frm.data('caResultId'), recurring_plans, 'r', {
                '{recurring_plan_id}': '%id',
                '{recurring_plan}': '%item'
            });
            {/literal}

            $.ceNotification('show', {
                type: 'N', 
                title: Tygh.tr('notice'), 
                message: Tygh.tr('text_items_added'), 
                message_state: 'I'
            });
        }

        return false;        
    });
}(Tygh, Tygh.$));
//]]>
</script>
{/if}

<form action="{$smarty.request.extra|fn_url}" method="post" data-ca-result-id="{$smarty.request.data_id}" name="recurring_plans_form">

{if $recurring_plans}
<table width="100%" class="table">
<tr>
    <th>
        {include file="common/check_items.tpl"}</th>
    <th>{__("rb_recurring_plan")}</th>
</tr>
{foreach from=$recurring_plans item=recurring_plan}
<tr>
    <td>
        <input type="checkbox" name="{$smarty.request.checkbox_name|default:"recurring_plans_ids"}[]" value="{$recurring_plan.plan_id}" class="checkbox cm-item" /></td>
    <td id="recurring_plan_{$recurring_plan.plan_id}" width="100%">{$recurring_plan.name}</td>
</tr>
{/foreach}
</table>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{if $recurring_plans}
<div class="buttons-container">
    {include file="buttons/add_close.tpl" but_text=__("rb_add_recurring_plans") but_close_text=__("rb_add_recurring_plans_and_close") is_js=$smarty.request.extra|fn_is_empty}
</div>
{/if}

</form>
