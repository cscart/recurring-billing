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

$schema['recurring_plans'] = array (
    'permissions' => 'manage_recurring_plans',
);
$schema['subscriptions'] = array (
    'permissions' => 'manage_subscriptions',
);
$schema['tools']['modes']['update_status']['param_permissions']['table']['recurring_plans'] = 'manage_recurring_plans';

return $schema;
