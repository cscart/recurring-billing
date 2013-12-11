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

if ($mode == 'details') {
    $view = Registry::get('view');
    $order_info = $view->getTemplateVars('order_info');

    $subscriptions = db_get_array("SELECT subscription_id FROM ?:recurring_subscriptions WHERE FIND_IN_SET(?i, order_ids)", $order_info['order_id']);

    if (!empty($subscriptions) && !fn_subscription_is_paid($order_info['status'])) {
        fn_prepare_repay_data(empty($_REQUEST['payment_id']) ? 0 : $_REQUEST['payment_id'], $order_info, $auth, $view);
        $view->assign('subscription_pay', true);
    }
}
