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

use Tygh\Mailer;
use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD']	== 'POST') {

    $suffix = '';

    if ($mode == 'update') {
        fn_change_recurring_subscription_status($_REQUEST['subscription_id'], $_REQUEST['status'], '', fn_get_notification_rules($_REQUEST));

        //Update shipping info
        if (!empty($_REQUEST['update_shipping'])) {
            $additional_data = db_get_hash_single_array("SELECT type, data FROM ?:order_data WHERE order_id = ?i", array('type', 'data'), $_REQUEST['order_id']);
            // Get shipping information
            if (!empty($additional_data['L'])) {
                $shippings = unserialize($additional_data['L']);
                if (!empty($shippings)) {
                    foreach ((array) $shippings as $shipping_id => $shipping) {
                        $shippings[$shipping_id] = fn_array_merge($shipping, $_REQUEST['update_shipping'][$shipping_id]);
                    }
                    db_query("UPDATE ?:order_data SET ?u WHERE order_id = ?i AND type = 'L'", array('data' => serialize($shippings)), $_REQUEST['order_id']);
                }
            }
        }

        $suffix = '.update?subscription_id=' . $_REQUEST['subscription_id'];
    }

    if ($mode == 'm_delete') {
        if (!empty($_REQUEST['subscription_ids'])) {
            fn_delete_recurring_subscriptions($_REQUEST['subscription_ids']);
        }

        $suffix = '.manage';
    }

    if ($mode == 'bulk_charge') {

        define('ORDER_MANAGEMENT', true);

        if (!empty($_REQUEST['subscription_ids'])) {
            foreach ($_REQUEST['subscription_ids'] as $_id) {
                fn_charge_subscription($_id);
            }
            fn_set_notification('N', __('notice'), __(sizeof($_REQUEST['subscription_ids']) == 1 ? 'rb_subscription_charged' : 'rb_subscriptions_charged'));
        }

        $suffix = '.manage';
    }

    if ($mode == 'process_events') {
        if (!empty($_REQUEST['process_subscriptions'])) {
            $subscriptions = $_REQUEST['process_subscriptions'];
            $events = Registry::get('recurring_billing_data.events');

            if (!fn_is_empty($subscriptions)) {
                $list_subscriptions = array();
                foreach ($events as $evt => $val) {
                    if (!empty($subscriptions[$evt])) {
                        foreach ($subscriptions[$evt] as $subs_id) {
                            $list_subscriptions[] = array('id' => $subs_id, 'type' => $evt);
                        }
                    }
                }

                $key = md5(uniqid(rand()));

                if (fn_set_storage_data('recurring_batch_' . $key, serialize($list_subscriptions))) {
                    return array(CONTROLLER_STATUS_OK, "subscriptions.batch_process_events?key=$key");
                }
            }
        }

        $suffix = '.events';
    }

    return array(CONTROLLER_STATUS_OK, "subscriptions$suffix");
}

// ---------------------- GET routines ---------------------------------------

if ($mode == 'batch_process_events' && !empty($_REQUEST['key'])) {

    $data = fn_get_storage_data('recurring_batch_' . $_REQUEST['key']);

    if (!empty($data)) {
        $data = @unserialize($data);
    }

    if (is_array($data)) {
        foreach (array_splice($data, 0, Registry::get('recurring_billing_data.events_per_pass')) as $evt) {
            if ($evt['type'] == 'A' || $evt['type'] == 'C') {
                fn_charge_subscription($evt['id']);
            } elseif ($evt['type'] == 'F' || $evt['type'] == 'M') {
                fn_recurring_subscription_notification($evt['id'], $evt['type']);
            }
            fn_echo(__('rb_subscription') . ' #' . $evt['id'] . ' ' . fn_strtolower(__('processed')) . '<br />');
        }

        if (!empty($data)) {

            fn_set_storage_data('recurring_batch_' . $_REQUEST['key'], serialize($data));

            return array(CONTROLLER_STATUS_OK, "subscriptions.batch_process_events?key=" . $_REQUEST['key']);
        } else {
            fn_set_storage_data('recurring_batch_' . $_REQUEST['key']);
            fn_set_notification('N', __('notice'), __('rb_subscriptions_processed'));
        }
    } else {
        fn_set_notification('W', __('warning'), __('rb_no_subscriptions_to_process'));
    }

    return array(CONTROLLER_STATUS_OK, "subscriptions.events");

} elseif ($mode == 'update') {
    $subscription = fn_get_recurring_subscription_info($_REQUEST['subscription_id'], true, true);

    if (empty($subscription)) {
        return array(CONTROLLER_STATUS_NO_PAGE);
    }

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
            'js' => true
        ),
    ));

    Registry::get('view')->assign('subscription', $subscription);

} elseif ($mode == 'manage') {

    list($subscriptions, $search) = fn_get_recurring_subscriptions($_REQUEST, Registry::get('settings.Appearance.admin_elements_per_page'));

    Registry::get('view')->assign('subscriptions', $subscriptions);
    Registry::get('view')->assign('search', $search);

} elseif ($mode == 'delete') {

    if (!empty($_REQUEST['subscription_id'])) {
        fn_delete_recurring_subscriptions((array) $_REQUEST['subscription_id']);
    }

    return array(CONTROLLER_STATUS_REDIRECT, "subscriptions.manage");

} elseif ($mode == 'update_status') {

    $old_status = db_get_field("SELECT status FROM ?:recurring_subscriptions WHERE subscription_id = ?i", $_REQUEST['id']);
    if (!fn_change_recurring_subscription_status($_REQUEST['id'], $_REQUEST['status'], $old_status, fn_get_notification_rules($_REQUEST), true)) {
        Registry::get('ajax')->assign('return_status', $old_status);
    }

    exit;

} elseif ($mode == 'charge') {

    define('ORDER_MANAGEMENT', true);

    if (!empty($_REQUEST['subscription_id'])) {
        fn_charge_subscription($_REQUEST['subscription_id']);
        fn_set_notification('N', __('notice'), __('rb_subscription_charged'));
    }

    return array(CONTROLLER_STATUS_REDIRECT, "subscriptions.manage");

} elseif ($mode == 'confirmation') {

    Registry::get('view')->assign('order_ids', $_SESSION['order_ids']);
    unset($_SESSION['order_ids']);

    Registry::get('view')->assign('subscriptions', $_SESSION['subscriptions']);
    unset($_SESSION['subscriptions']);

    Registry::get('view')->assign('redirect_url', $_SESSION['redirect_url']);
    unset($_SESSION['redirect_url']);

} elseif ($mode == 'events') {

    fn_delete_notification('rb_events');
    $events = fn_get_recurring_events();

    if (!fn_is_empty($events)) {
        Registry::get('view')->assign('recurring_events', $events);
        Registry::get('view')->assign('recurring_billing_data', Registry::get('recurring_billing_data'));
    }

} elseif ($mode == 'process_event') {

    if (!empty($_REQUEST['subscription_id']) && !empty($_REQUEST['type'])) {
        $list_subscriptions = array(
            array(
                'id' => $_REQUEST['subscription_id'],
                'type' => $_REQUEST['type']
            )
        );

        $key = md5(uniqid(rand()));

        if (fn_set_storage_data('recurring_batch_' . $key, serialize($list_subscriptions))) {
            return array(CONTROLLER_STATUS_OK, "subscriptions.batch_process_events?key=$key");
        }
    }

    return array(CONTROLLER_STATUS_REDIRECT, "subscriptions.events");
}

//
// [Functions]
//

function fn_charge_subscription($subscription_id)
{
    $_SESSION['cart'] = isset($_SESSION['cart']) ? $_SESSION['cart'] : array();
    $cart = & $_SESSION['cart'];

    $_SESSION['customer_auth'] = isset($_SESSION['customer_auth']) ? $_SESSION['customer_auth'] : array();
    $customer_auth = & $_SESSION['customer_auth'];

    fn_clear_cart($cart, true);
    $customer_auth = fn_fill_auth();

    if (!fn_calculate_subscription_data($subscription_id, $cart, $customer_auth)) {
        fn_set_notification('E', __('error'), __('rb_subscription_inactive'));
    } else {

        list($order_id, $process_payment) = fn_place_order($cart, $customer_auth);
        if (!empty($order_id)) {
            $order_info = fn_get_order_info($order_id, true);
            $evt_data = array (
                'subscription_id' => $subscription_id,
                'timestamp' => $order_info['timestamp'],
                'event_type' => 'C'
            );

            db_query("INSERT INTO ?:recurring_events ?e", $evt_data);

            if ($process_payment == true) {
                $payment_info = !empty($cart['payment_info']) ? $cart['payment_info'] : array();
                fn_start_payment($order_id, array(), $payment_info);
            }

            $edp_data = fn_generate_ekeys_for_edp(array(), $order_info);
            fn_order_notification($order_info, $edp_data);
        }
    }
}

function fn_recurring_subscription_notification($subscription_id, $notification_type)
{
    $data = fn_get_recurring_subscription_info($subscription_id, true);
    $evt_data = array (
        'subscription_id' => $subscription_id,
        'timestamp' => TIME,
    );

    if ($notification_type == 'F') {

        $data['next_timestamp'] = db_get_field("SELECT timestamp FROM ?:recurring_events WHERE subscription_id = ?i AND event_type = 'P' AND timestamp > ?i GROUP BY subscription_id", $subscription_id, TIME);

        Mailer::sendMail(array(
            'to' => $data['email'],
            'from' => 'default_company_orders_department',
            'data' => array(
                'subscription_info' => $data,
                'header' => __('rb_future_pay_email_header', '', $data['order_info']['lang_code']),
                'subj' => __('rb_future_pay_email_subject', '', $data['order_info']['lang_code'])
            ),
            'tpl' => 'addons/recurring_billing/future_notification.tpl',
        ), 'C', $data['order_info']['lang_code']);

    } elseif ($notification_type == 'M') {

        Mailer::sendMail(array(
            'to' => $data['email'],
            'from' => 'default_company_orders_department',
            'data' => array(
                'subscription_info' => $data,
                'header' => __('rb_manual_pay_email_header', '', $data['order_info']['lang_code']),
                'subj' => __('rb_manual_pay_email_subject', '', $data['order_info']['lang_code'])
            ),
            'tpl' => 'addons/recurring_billing/manual_notification.tpl',
        ), 'C', $data['order_info']['lang_code']);

    } else {
        return false;
    }

    $evt_data['event_type'] = $notification_type;
    db_query("INSERT INTO ?:recurring_events ?e", $evt_data);

    return true;
}

//
// [/Functions]
//
