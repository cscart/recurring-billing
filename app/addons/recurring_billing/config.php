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
use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

Registry::set('recurring_billing_data', array(
    'periods' => array(
        'A' => 'rb_annually',
        'Q' => 'rb_quarterly',
        'M' => 'rb_monthly',
        'W' => 'rb_weekly',
        'P' => 'rb_by_period'
    ),
    'price' => array('original', 'to_percentage', 'by_percentage', 'to_fixed', 'by_fixed'),
    'events' => array(
        'A' => 'rb_attempt_charging',
        'C' => 'rb_charge_subscription',
        'F' => 'rb_notification_future_paying',
        'M' => 'rb_notification_manual_paying'
    ),
    'events_per_pass' => 10
));
