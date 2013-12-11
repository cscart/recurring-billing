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

if ($_SERVER['REQUEST_METHOD']	== 'POST') {
    $suffix = '';

    // Define trusted variables that shouldn't be stripped
    fn_trusted_vars ('recurring_plan');

    //
    // Update/add plan
    //
    if ($mode == 'update') {
        $plan_id = fn_update_recurring_plan($_REQUEST['recurring_plan'], $_REQUEST['plan_id'], DESCR_SL);

        $suffix = ".update?plan_id=$plan_id";
    }

    //
    // Delete selected plans
    //
    if ($mode == 'm_delete') {
        if (!empty($_REQUEST['plan_ids'])) {
            fn_delete_recurring_plans($_REQUEST['plan_ids']);
        }

        $suffix = '.manage';
    }

    return array(CONTROLLER_STATUS_OK, "recurring_plans$suffix");
}


// ---------------------- GET routines ---------------------------------------

if ($mode == 'update') {
    $recurring_plan = fn_get_recurring_plan_data($_REQUEST['plan_id'], DESCR_SL);

    if (empty($recurring_plan)) {
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
    ));

    Registry::get('view')->assign('recurring_plan', $recurring_plan);
    Registry::get('view')->assign('recurring_billing_data', Registry::get('recurring_billing_data'));

} elseif ($mode == 'add') {

    Registry::set('navigation.tabs', array (
        'general' => array (
            'title' => __('general'),
            'js' => true
        ),
        'linked_products' => array (
            'title' => __('products'),
            'js' => true
        ),
    ));

    Registry::get('view')->assign('recurring_billing_data', Registry::get('recurring_billing_data'));

} elseif ($mode == 'manage' || $mode == 'picker') {

    list($plans, $search) = fn_get_recurring_plans($_REQUEST, Registry::get('settings.Appearance.admin_elements_per_page'), DESCR_SL);

    Registry::get('view')->assign('recurring_plans', $plans);
    Registry::get('view')->assign('search', $search);

} elseif ($mode == 'delete') {

    if (!empty($_REQUEST['plan_id'])) {
        fn_delete_recurring_plans((array) $_REQUEST['plan_id']);
    }

    return array(CONTROLLER_STATUS_REDIRECT, "recurring_plans.manage");
}

//
// Recurring plans picker
//
if ($mode == 'picker') {
    Registry::get('view')->display('addons/recurring_billing/pickers/recurring_plans/picker_contents.tpl');
    exit;
}

//
// [Functions]
//

//
// Delete recurring plans
//
function fn_delete_recurring_plans($plans_ids)
{
    if (!empty($plans_ids)) {
        if (!is_array($plans_ids)) {
            $plans_ids = explode(',', $plans_ids);
        }
        db_query("DELETE FROM ?:common_descriptions WHERE object_holder = 'recurring_plans' AND object_id IN (?n)", $plans_ids);
        db_query("DELETE FROM ?:recurring_plans WHERE plan_id IN (?n)", $plans_ids);
    }
}

//
// Update recurring plan
//
function fn_update_recurring_plan($data, $plan_id, $lang_code = DESCR_SL)
{
    $data['price'] = serialize(array('type' => $data['price_type'], 'value' => $data['price_value']));

    if (isset($data['start_price_value'])) {
        $data['start_price'] = serialize(array('type' => $data['start_price_type'], 'value' => $data['start_price_value']));
    }

    if ($data['period'] == 'P' && $data['pay_day'] > $data['by_period']) {
        $data['pay_day'] = $data['by_period'];
    }

    if (!empty($plan_id)) {
        $condition = db_quote(" AND plan_id = ?i", $plan_id);

        if (fn_allowed_for('ULTIMATE')) {
            if (Registry::get('runtime.company_id')) {
                $company_id = db_get_field("SELECT company_id FROM ?:recurring_plans WHERE plan_id = ?i", $plan_id);
                if (Registry::get('runtime.company_id') != $company_id) {
                    //Check that we are the owner of selected plan
                    fn_set_notification('W', __('warning'), __('rb_please_select_store_to_update'));

                    return $plan_id;
                } else {
                    $data['company_id'] = Registry::get('runtime.company_id');
                }

            } else {
                //Root admin can't update recurring plans
                fn_set_notification('W', __('warning'), __('rb_please_select_store'));

                return $plan_id;
            }
        }

        db_query("UPDATE ?:recurring_plans SET ?u WHERE 1 $condition", $data, $plan_id);
        $data['object'] = $data['name'];
        db_query("UPDATE ?:common_descriptions SET ?u WHERE object_id = ?i AND object_holder = 'recurring_plans' AND lang_code = ?s", $data, $plan_id, $lang_code);
    } else {
        if (fn_allowed_for('ULTIMATE')) {
            $data['company_id'] = Registry::ifGet('runtime.company_id', 1);
        }

        $plan_id = $data['plan_id'] = db_query("INSERT INTO ?:recurring_plans ?e", $data);

        if (!empty($plan_id)) {
            $_data = array(
                'object' => $data['name'],
                'description' => $data['description'],
                'object_id' => $plan_id,
                'object_holder' => 'recurring_plans'
            );

            foreach (fn_get_translation_languages() as $_data['lang_code'] => $_ldata) {
                db_query("INSERT INTO ?:common_descriptions ?e", $_data);
            }
        }
    }

    return $plan_id;
}

//
// [/Functions]
//
