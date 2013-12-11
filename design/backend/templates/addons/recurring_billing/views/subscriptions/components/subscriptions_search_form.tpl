<div class="sidebar-row">
    <h6>{__("search")}</h6>
<form action="{""|fn_url}" name="subscriptions_search_form" method="get">

{capture name="simple_search"}
    <div class="sidebar-field">
        <label for="cname">{__("customer")}:</label>
        <div class="break">
            <input type="text" name="cname" id="cname" value="{$search.cname}" size="30" />
        </div>
    </div>

    <div class="sidebar-field">
        <label for="email">{__("email")}:</label>
        <div class="break">
            <input type="text" name="email" id="email" value="{$search.email}" size="30"/>
        </div>
    </div>

    <div class="sidebar-field">
        <label for="price_from">{__("rb_price")}&nbsp;({$currencies.$primary_currency.symbol nofilter}):</label>
        <input type="text" name="price_from" id="price_from" value="{$search.price_from}" size="3" class="input-small" />&nbsp;-&nbsp;<input type="text" name="price_to" value="{$search.price_to}" size="3" class="input-small" />

    </div>
{/capture}

{capture name="advanced_search"}

<div class="row-fluid">
    <div class="group span6 form-horizontal">
        <div class="control-group">
        <label class="control-label" for="status">{__("rb_subscription_status")}:</label>
            <div class="controls">
                <select name="status" id="status">
                    <option value="">--</option>
                    <option value="A"{if $search.status == "A"} selected="selected"{/if}>{__("active")}</option>
                    <option value="D"{if $search.status == "D"} selected="selected"{/if}>{__("disabled")}</option>
                    <option value="U"{if $search.status == "U"} selected="selected"{/if}>{__("rb_unsubscribed")}</option>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="type_period">{__("rb_period_type")}:</label>
            <div class="controls">
                <select name="period_type" id="type_period">
                    <option value="">--</option>
                    <option value="D"{if $search.period_type == "D"} selected="selected"{/if}>{__("date")}</option>
                    <option value="L"{if $search.period_type == "L"} selected="selected"{/if}>{__("last_order")}</option>
                    <option value="E"{if $search.period_type == "E"} selected="selected"{/if}>{__("end_date")}</option>
                </select>
            </div>
        </div>
    </div>
    <div class="group span6 form-horizontal">
        <div class="control-group">
            <label class="control-label" for="order_id">{__("order_id")}:</label>
            <div class="controls">
                <input type="text" name="order_id" id="order_id" value="{$search.order_id}" size="10" />
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="plan_id">{__("rb_recurring_plan_id")}:</label>
            <div class="controls">
                <input type="text" name="plan_id" id="plan_id" value="{$search.plan_id}" size="10" />
            </div>
        </div>
    </div>
</div>

<div class="group form-horizontal">
    <div class="control-group">
        <label class="control-label">{__("period")}</label>
        <div class="controls">
        {include file="common/period_selector.tpl" period=$search.period form_name="orders_search_form"}
        </div>
    </div>
</div>

<div class="group form-horizonta">
<div class="control-group">
    <label>{__("rb_subscribed_products")}:</label>
    <div class="controls">
        {include file="common/products_to_search.tpl"}
    </div>
</div>
</div>
{/capture}

{include file="common/advanced_search.tpl" advanced_search=$smarty.capture.advanced_search simple_search=$smarty.capture.simple_search dispatch=$dispatch view_type="subscriptions"}

</form>
</div>