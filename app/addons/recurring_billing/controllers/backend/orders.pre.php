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

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if ($mode == 'delete_orders' && !empty($_REQUEST['order_ids'])) {
        $res = fn_delete_corresponding_subscription($_REQUEST['order_ids'], empty($_REQUEST['confirmed']));
        if (!$res) {
            $_SESSION['redirect_url'] = $_REQUEST['redirect_url'];
            unset($_REQUEST['redirect_url']);

            return array(CONTROLLER_STATUS_REDIRECT, "subscriptions.confirmation");
        }
    }

    return;
}

if ($mode == 'delete') {
    $res = fn_delete_corresponding_subscription((array) $_REQUEST['order_id']);
    if (!$res) {
        $_SESSION['redirect_url'] = $_REQUEST['redirect_url'];
        unset($_REQUEST['redirect_url']);

        return array(CONTROLLER_STATUS_REDIRECT, "subscriptions.confirmation");
    }
}

function fn_delete_corresponding_subscription($order_ids, $not_confirmed = true)
{
    $subscriptions = db_get_hash_single_array("SELECT subscription_id, order_id FROM ?:recurring_subscriptions WHERE order_id IN (?n)", array('subscription_id', 'order_id'), $order_ids);

    if (!empty($subscriptions)) {
        if ($not_confirmed) {
            $_SESSION['subscriptions'] = $subscriptions;
            $_SESSION['order_ids'] = $order_ids;

            return false;
        } else {
            fn_delete_recurring_subscriptions(array_keys($subscriptions));
        }
    }

    foreach ($order_ids as $order_id) {
        $subs = db_get_array("SELECT subscription_id, order_ids FROM ?:recurring_subscriptions WHERE FIND_IN_SET(?i, order_ids)", $order_id);
        if (!empty($subs)) {
            foreach ($subs as $val) {
                $new_order_ids = explode(',', $val['order_ids']);
                $new_order_ids = array_diff($new_order_ids, $order_ids);

                db_query("UPDATE ?:recurring_subscriptions SET order_ids = ?s WHERE subscription_id = ?i", implode(',', $new_order_ids), $val['subscription_id']);
            }
        }
    }

    return true;
}
