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

$schema['central']['orders']['items']['rb_recurring_plans'] = array(
    'attrs' => array(
        'class'=>'is-addon'
    ),
    'href' => 'recurring_plans.manage',
    'position' => 801
);
$schema['central']['orders']['items']['rb_view_subscriptions'] = array(
    'attrs' => array(
        'class'=>'is-addon'
    ),
    'href' => 'subscriptions.manage',
    'position' => 802
);
$schema['central']['orders']['items']['rb_subscription_events'] = array(
    'attrs' => array(
        'class'=>'is-addon'
    ),
    'href' => 'subscriptions.events',
    'position' => 803
);

return $schema;
