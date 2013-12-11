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

use Tygh\Registry;

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if ($mode == 'update') {
        if (!empty($_REQUEST['additional_orders_settings'])) {
            foreach ($_REQUEST['additional_orders_settings'] as $lang_var_name => $lang_var_value) {
                $lang_data[0] = array(
                    'name' => $lang_var_name,
                    'value' => $lang_var_value,
                    'overwrite' => Registry::get('runtime.company_id') ? 'N' : 'Y'
                );
                fn_update_lang_var($lang_data, DESCR_SL, array('clear' => false));
            }
        }

        if (!empty($_REQUEST['additional_notification_settings'])) {
            foreach ($_REQUEST['additional_notification_settings'] as $lang_var_name => $lang_var_value) {
                $lang_data[0] = array(
                    'name' => $lang_var_name,
                    'value' => $lang_var_value,
                    'overwrite' => Registry::get('runtime.company_id') ? 'N' : 'Y'
                );
                fn_update_lang_var($lang_data, DESCR_SL, array('clear' => false));
            }
        }
    }
}
