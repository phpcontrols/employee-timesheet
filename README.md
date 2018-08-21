# employee-timesheet

Employee Timesheet demo application

Companion files to the tutorial [Create the perfect employee timesheet system in PHP and MySQL](https://medium.com/@chensformers/a-simple-employee-timesheet-in-php-and-mysql-eea7963c6045)

# Common Issue

Fatal error: Uncaught Error: Class 'phpGrid\C_DataGrid' not found

# How to fix

If you are using the free Lite version, you can either comment out the first line
// use phpGrid\C_DataGrid;
 - OR - 
Add a global namespace symbol - single backslash - BEFORE the constructor 
$dg = new \C_DataGrid("SELECT * FROM orders", "orderNumber", "orders");
