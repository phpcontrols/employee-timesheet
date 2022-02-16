<?php
use phpGrid\C_DataGrid;

require_once("phpGrid/conf.php");      
?>
<!DOCTYPE html>
<html>
<head>
	<title>EMPLOYEE TIMESHEET</title>
</head>
<body style="margin:20px 100px">
	<h1>EMPLOYEE TIMESHEET</h1>
	<div>
		<h3>Your dashboard | <a href="index.php">home</a></h3>
		Click + to add the start and end time for the day's hours:
		<?php
		$dg = new C_DataGrid("SELECT * FROM timesheet", "id", "timesheet");
		$dg -> set_query_filter("employee_id = '1'");

		$dg -> set_col_hidden('id, employee_id', false);

		// $dg -> set_col_edittype("employee_id", "select", "Select id, last_name from account")->set_col_title('employee_id', 'Employee'); 
		$dg -> set_col_edittype("activity_id", "select", "Select id, code from activity")->set_col_title('activity_id', 'Activity');
	
		$dg -> set_col_time("time_from")->set_col_property("time_from",
            array("formatter"=>"date", "formatoptions"=>array("srcformat"=>"h:i","newformat"=>"h:i A")));
		$dg -> set_col_time("time_to")->set_col_property("time_to",
            array("formatter"=>"date", "formatoptions"=>array("srcformat"=>"h:i","newformat"=>"h:i A")));

		$dg -> enable_edit('FORM')->enable_autowidth(true);

		$dg -> display();
		?>

</body>
</html>