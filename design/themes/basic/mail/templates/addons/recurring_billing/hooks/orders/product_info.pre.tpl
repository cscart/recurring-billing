{if $oi.extra.recurring_plan_id}
    <p>{__("rb_recurring_plan")}: {$oi.extra.recurring_plan.name}</p>
    <p>{__("rb_recurring_period")}: <span class="lowercase">{$oi.extra.recurring_plan.period|fn_get_recurring_period_name}</span>{if $oi.extra.recurring_plan.period == "P"} - {$oi.extra.recurring_plan.by_period} {__("days")}{/if}</p>
    <p>{__("rb_duration")}: {$oi.extra.recurring_duration}</p>
    {if $oi.extra.recurring_plan.start_duration}
    <p>{__("rb_start_duration")}: {$oi.extra.recurring_plan.start_duration} {if $oi.extra.recurring_plan.start_duration_type == "D"}{__("days")}{else}{__("months")}{/if}</p>
    {/if}
{/if}