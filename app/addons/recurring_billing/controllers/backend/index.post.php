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

if (!defined('BOOTSTRAP')) { die('Access denied'); }

// Generate dashboard
if ($mode == 'index') {

    $events = fn_get_recurring_events();

    if (!fn_is_empty($events)) {
        fn_delete_notification('rb_events');
        fn_set_notification('N', __('notice'), __('rb_have_events', array(
            '[link]' => fn_url("subscriptions.events")
        )), "S", 'rb_events');
    }

}
