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

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    return;
}

if ($mode == 'manage') {
    if (fn_check_permissions('recurring_plans', 'picker', 'admin', 'POST')) {
        Registry::set('navigation.tabs.recurring_plan_0', array (
            'title' => __('rb_recurring_plans'),
            'js' => true
        ));
    }

} elseif ($mode == 'update') {
    if (fn_check_permissions('recurring_plans', 'picker', 'admin', 'POST')) {
        $usergroup = Registry::get('view')->getTemplateVars('usergroup');
        $usergroup['recurring_plans_ids'] = db_get_field("SELECT recurring_plans_ids FROM ?:usergroups WHERE usergroup_id = ?i", $_REQUEST['usergroup_id']);
        Registry::get('view')->assign('usergroup', $usergroup);

        Registry::set('navigation.tabs.recurring_plan_' . $_REQUEST['usergroup_id'], array (
            'title' => __('rb_recurring_plans'),
            'js' => true
        ));
    }
}
