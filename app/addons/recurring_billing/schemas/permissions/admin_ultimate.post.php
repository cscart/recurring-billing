<?php
/***************************************************************************
*                                                                          *
*   (c) 2004 Vladimir V. Kalynyak, Alexey V. Vinokurov, Ilya M. Shalnev    *
*                                                                          *
* This  is  commercial  software,  only  users  who have purchased a valid *
* license  and  accept  to the terms of the  License Agreement can install *
* and use this program.                                                    *
*                                                                          *
****************************************************************************
* PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
* "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
****************************************************************************/

$schema['recurring_plans']['vendor_only'] = true;
$schema['recurring_plans']['use_company'] = true;
$schema['recurring_plans']['page_title'] = 'recurring_plans';
$schema['subscriptions']['vendor_only'] = true;
$schema['subscriptions']['use_company'] = true;
$schema['subscriptions']['page_title'] = 'subscriptions';
$schema['subscriptions']['modes']['events']['vendor_only'] = true;
$schema['subscriptions']['modes']['events']['use_company'] = true;
$schema['subscriptions']['modes']['events']['page_title'] = 'rb_subscription_events';

return $schema;
