<?php
use phpGrid\C_DataGrid;

require_once("phpGrid/conf.php");      
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="assets/css/style.css" rel="stylesheet">
	<title>EMPLOYEE TIMESHEET</title>
</head>
<body style="margin:20px 100px;">

<h1>EMPLOYEE TIMESHEET</h1>
<h3>Supervisor Dashboard | <a href="index.php">home</a></h3>

<p>Click on a tab to view its detail.</p>

<?php
$dg = new C_DataGrid("SELECT id, employee_id, date, 
		time_from, time_to, ROUND(TIMESTAMPDIFF(MINUTE, time_from, time_to)/60, 2) as hours, 
		comments, activity_id, date_submitted 
		FROM timesheet", "id", "timesheet");

$dg -> set_col_hidden('id', false);

// hide aggregate field hours from edit form
$dg->set_col_property('hours', array('editable'=>false,'hidedlg'=>true));

$dg -> set_col_edittype("employee_id", "select", "Select id, last_name from account")->set_col_title('employee_id', 'Employee'); 
$dg -> set_col_edittype("activity_id", "select", "Select id, code from activity")->set_col_title('activity_id', 'Activity');

$dg -> set_col_time("time_from")->set_col_property("time_from",
    array("formatter"=>"date", "formatoptions"=>array("srcformat"=>"h:i A","newformat"=>"h:i A")));
$dg -> set_col_time("time_to")->set_col_property("time_to",
    array("formatter"=>"date", "formatoptions"=>array("srcformat"=>"h:i A","newformat"=>"h:i A")));

$dg -> enable_edit('FORM')->enable_autowidth(true);

$dg -> set_group_properties('employee_id', false, true, true, false)->set_group_summary('hours', 'sum'); 

$dg -> display(false);
$grid = $dg -> get_display(false);

$dg -> display_script_includeonce();
?>






<div id="tabs">
    <div id="tabs-1" style="padding:0">
        <?php 
        echo $grid;
        ?>
    </div>
    <ul>
        <li><a href="#tabs-1">Timesheets</a></li>
        <li><a href="tabbed_grid_loader.php?gn=account">Employees</a></li>
        <li><a href="tabbed_grid_loader.php?gn=activity">Activities</a></li>
        <li><a href="tabbed_grid_loader.php?gn=cost_center">Cost Center</a></li>
        <li><a href="tabbed_grid_loader.php?gn=project">Projects</a></li>
        <li style="background:transparent;border:0;"><a onclick="location.href='https://getzenbase.com'" href="https://getzenbase.com" target="_new" style="padding:0;padding-left: 10px;"><img src="assets/images/zenbase-logo.png" width="85"></a></li>
    </ul>
</div>



<script>
  $( function() {
    $( "#tabs" ).tabs({
        beforeLoad: function(event, ui) {
            if(ui.panel.html() == ""){
                ui.panel.html('<div class="loading">Loading...</div>');
                return true;
            } else {
                return false;
            }
        }
    });
  } );
</script>




</body>
</html> 
