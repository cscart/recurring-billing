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

$schema['recurring_plans.update'] = array(
        'func' => array('fn_get_recurring_plan_name', '@plan_id'),
        'text' => 'rb_recurring_plan'
);
$schema['subscriptions.update'] = array(
        'func' => array('fn_get_subscription_name', '@subscription_id'),
        'text' => 'rb_subscription'
);

return $schema;
