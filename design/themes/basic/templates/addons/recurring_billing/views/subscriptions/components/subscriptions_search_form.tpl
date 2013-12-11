{capture name="section"}

<form action="{""|fn_url}" name="subscriptions_search_form" method="get">

<div class="control-group">
    <label>{__("price")} ({$currencies.$primary_currency.symbol nofilter})</label>
    <input type="text" name="price_from" value="{$search.price_from}" size="6" class="input-text-short" />&nbsp;-&nbsp;<input type="text" name="price_to" value="{$search.price_to}" size="6" class="input-text-short" />
</div>

<div class="control-group">
    <div class="period-type">
    <label for="type_period">{__("rb_period_type")}</label>
    <select name="period_type" id="type_period">
        <option value="">--</option>
        <option value="D"{if $search.period_type == "D"} selected="selected"{/if}>{__("date")}</option>
        <option value="L"{if $search.period_type == "L"} selected="selected"{/if}>{__("last_order")}</option>
        <option value="E"{if $search.period_type == "E"} selected="selected"{/if}>{__("end_date")}</option>
    </select>
    </div>
    {include file="common/period_selector.tpl" period=$search.period form_name="subscriptions_search_form" tim_from=$search.time_from time_to=$search.time_to}
</div>


    
<div class="buttons-container">{include file="buttons/button.tpl" but_text=__("search") but_name="dispatch[subscriptions.search]"}</div>
</form>

{/capture}
{include file="common/section.tpl" section_title=__("search") section_content=$smarty.capture.section}
