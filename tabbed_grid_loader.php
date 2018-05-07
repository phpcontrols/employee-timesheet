<?php
// companion loader file for tabbed_grid.php (Tabbed datagrid)

use phpGrid\C_DataGrid;
require_once("phpGrid/conf.php");      

$tableName = (isset($_GET['gn']) && isset($_GET['gn']) !== '') ? $_GET['gn'] : 'timesheet';

// SECURITY CHECK
$tablesWhitelist = array('account', 'project', 'activity', 'cost_center', 'timesheet');

if(!in_array($tableName, $tablesWhitelist))
	die("The table $tableName is not whitelisted.");

$dg = new C_DataGrid("SELECT * FROM ". $tableName);
$dg->enable_edit('FORM')->enable_autowidth(true);
$dg -> display();
