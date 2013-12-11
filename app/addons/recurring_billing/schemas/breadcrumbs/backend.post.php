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

$schema['recurring_plans.update'] = array (
    array(
        'title' => 'rb_recurring_plans',
        'link' => 'recurring_plans.manage'
    )
);
$schema['subscriptions.update'] = array (
    array (
        'type' => 'search',
        'prev_dispatch' => 'subscriptions.manage',
        'title' => 'search_results',
        'link' => 'subscriptions.manage.last_view'
    ),
    array (
        'title' => 'rb_subscriptions',
        'link' => 'subscriptions.manage.reset_view'
    )
);
$schema['subscriptions.confirmation'] = array (
    array(
        'title' => 'orders',
        'link' => 'orders.manage'
    )
);

return $schema;
