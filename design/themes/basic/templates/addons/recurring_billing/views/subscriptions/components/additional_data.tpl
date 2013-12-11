{assign var="item_ids" value=","|explode:$data}
{foreach from=$item_ids item="item_id"}
<p>{$item_id|fn_get_product_name}</p>
{/foreach}