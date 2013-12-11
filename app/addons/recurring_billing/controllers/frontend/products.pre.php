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

if ($mode == 'view' || $mode == 'options') {
    if (!empty($_REQUEST['cart_id'])) {
        $cart = & $_SESSION['cart'];
        if (isset($cart['products'][$_REQUEST['cart_id']]['extra']['recurring_plan_id'])) {
            Registry::set('recurring_plan_id', $cart['products'][$_REQUEST['cart_id']]['extra']['recurring_plan_id']);
        }
    }
}
