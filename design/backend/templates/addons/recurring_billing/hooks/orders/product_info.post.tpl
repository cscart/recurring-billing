{if $oi.extra.recurring_plan_id && !($runtime.controller == "subscriptions" && $runtime.mode == "update")}
    <ul class="unstyled shift-top">
        <li><strong>{__("rb_recurring_plan")}:</strong> {$oi.extra.recurring_plan.name}</li>
        <li><strong>{__("rb_recurring_period")}:</strong> <span class="lowercase">{$oi.extra.recurring_plan.period|fn_get_recurring_period_name}</span>{if $oi.extra.recurring_plan.period == "P"} - {$oi.extra.recurring_plan.by_period} {__("days")}{/if}</li>
        <li><strong>{__("rb_duration")}:</strong> {$oi.extra.recurring_duration}</li>
    {if $oi.extra.recurring_plan.start_duration}
        <li><strong>{__("rb_start_duration")}:</strong> {$oi.extra.recurring_plan.start_duration} {if $oi.extra.recurring_plan.start_duration_type == "D"}{__("days")}{else}{__("months")}{/if}</li>
    {/if}
    </ul>
{/if}