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
    if ($mode == 'add') {
        if (!empty($_REQUEST['product_data'])) {
            list($product_id, $_data) = each($_REQUEST['product_data']);

            if (!empty($_data['cart_id'])) {
                unset($_REQUEST['redirect_url']);

                return array(CONTROLLER_STATUS_REDIRECT, "checkout." . (!empty($_data['return_mode']) ? $_data['return_mode'] : 'cart'));
            }
        }
    }
}
