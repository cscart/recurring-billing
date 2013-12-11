<div id="content_recurring_plan_{$id}">
{if "dispatch=recurring_plans.picker"|fn_check_view_permissions:"POST" && $usergroup.type == "C"}
    {include file="addons/recurring_billing/pickers/recurring_plans/picker.tpl" data_id="add_recurring_plans" input_name="usergroup_data[recurring_plans_ids]" item_ids=$usergroup.recurring_plans_ids}
{/if}
</div>
