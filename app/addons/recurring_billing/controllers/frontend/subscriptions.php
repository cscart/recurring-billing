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

if (!empty($_REQUEST['subscription_id']) && $mode != 'search' && $mode != 'update') {
    // If user is not logged in and trying to see the order, redirect him to login form
    if (empty($auth['user_id']) && empty($auth['order_ids'])) {
        return array(CONTROLLER_STATUS_REDIRECT, "auth.login_form?return_url=" . urlencode(Registry::get('config.current_url')));
    }

    if (!empty($auth['user_id'])) {
        $allowed_id = db_get_field("SELECT user_id FROM ?:recurring_subscriptions WHERE user_id = ?i AND subscription_id = ?i", $auth['user_id'], $_REQUEST['subscription_id']);

    } elseif (!empty($auth['order_ids'])) {
        $orders = db_get_field("SELECT order_ids FROM ?:recurring_subscriptions WHERE subscription_id = ?i", $_REQUEST['subscription_id']);
        $ord_ids = explode(',', $orders);
        $allowed_id = array_intersect($ord_ids, $auth['order_ids']);
    }

    if (empty($allowed_id)) { // Access denied

        return array(CONTROLLER_STATUS_DENIED);
    }
}

if ($_SERVER['REQUEST_METHOD']	== 'POST') {

    $suffix = '';

    if ($mode == 'update') {
        if (!empty($_REQUEST['update_duration'])) {

            if (!empty($auth['user_id'])) {
                $condition = db_quote("AND user_id = ?i", $auth['user_id']);

            } elseif (!empty($auth['order_ids'])) {
                $condition = db_quote("AND FIND_IN_SET(order_id, ?s)", implode(',', $auth['order_ids']));

            } else {
                return array(CONTROLLER_STATUS_DENIED);
            }

            $negative = false;
            foreach ($_REQUEST['update_duration'] as $id => $duration) {
                if ($duration > 0) {
                    $subscription_data = db_get_row("SELECT timestamp, plan_id FROM ?:recurring_subscriptions WHERE subscription_id = ?i AND status = 'A' $condition", $id);
                    $_data = array(
                        'end_timestamp' => fn_get_period_date($subscription_data['timestamp'], $duration),
                        'duration' => $duration
                    );
                    db_query("UPDATE ?:recurring_subscriptions SET ?u WHERE subscription_id = ?i", $_data, $id);
                    fn_change_subscription_dates($id, $subscription_data['plan_id'], $subscription_data['timestamp'], $duration);

                } else {
                    $negative = true;
                }
            }

            if ($negative) {
                fn_set_notification('E', __('error'), 'rb_duration_did_not_null');
            }
        }

        $suffix = empty($_REQUEST['subscription_id']) ? '.search' : '.view?subscription_id=' . $_REQUEST['subscription_id'];
    }

    if ($mode == 'unsubscribe') {

        if (!empty($_REQUEST['subscription_id'])) {
            fn_change_recurring_subscription_status($_REQUEST['subscription_id'], 'U');
        }

        $suffix = '.search';
    }

    return array(CONTROLLER_STATUS_OK, "subscriptions$suffix");
}

// ---------------------- GET routines ---------------------------------------

if ($mode == 'view') {
    $subscription = fn_get_recurring_subscription_info($_REQUEST['subscription_id'], true, true);

    if (empty($subscription)) {
        return array(CONTROLLER_STATUS_NO_PAGE);
    }

    fn_add_breadcrumb(__('rb_subscriptions'), "subscriptions.search");
    fn_add_breadcrumb(__('rb_subscription') . ' #' . $subscription['subscription_id']);

    Registry::set('navigation.tabs', array (
        'general' => array (
            'title' => __('general'),
            'js' => true
        ),
        'linked_products' => array (
            'title' => __('products'),
            'js' => true
        ),
        'paids' => array (
            'title' => __('orders'),
            'href' => 'orders.search?order_id=' . $subscription['order_ids'],
            'ajax' => true
        ),
    ));

    if ($subscription['order_id'] == $subscription['order_ids']) {
        $last_status = $subscription['order_info']['status'];
        $pay_order = $subscription['order_id'];
    } else {
        $pay_order = substr($subscription['order_ids'], strrpos($subscription['order_ids'], ',') + 1);
        $last_order = fn_get_order_short_info($pay_order);
        $last_status = $last_order['status'];
    }
    if (!fn_subscription_is_paid($last_status)) {
        Registry::get('view')->assign('subscription_pay_order_id', $pay_order);
    }

    Registry::get('view')->assign('subscription', $subscription);

} elseif ($mode == 'search') {
    fn_add_breadcrumb(__('rb_subscriptions'));

    $params = $_REQUEST;
    $params['plan_options'] = true;
    unset($params['user_id'], $params['order_ids']);

    if (!empty($auth['user_id'])) {
        $params['user_id'] = $auth['user_id'];

    } elseif (!empty($auth['order_ids'])) {
        $params['order_ids'] = $auth['order_ids'];

    } else {
        return array(CONTROLLER_STATUS_REDIRECT, "auth.login_form?return_url=" . urlencode(Registry::get('config.current_url')));
    }

    list($subscriptions, $search) = fn_get_recurring_subscriptions($params, Registry::get('settings.Appearance.elements_per_page'));

    Registry::get('view')->assign('subscriptions', $subscriptions);
    Registry::get('view')->assign('search', $search);

} elseif ($mode == 'unsubscribe') {

    if (!empty($_REQUEST['subscription_id'])) {
        fn_change_recurring_subscription_status($_REQUEST['subscription_id'], 'U');
    }

    return array(CONTROLLER_STATUS_REDIRECT, "subscriptions.search");

}
