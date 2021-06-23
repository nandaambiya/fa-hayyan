<?php
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

if (isset($_SESSION['admin'])) {
	$koneksi = new mysqli("localhost","admin_fa-hayyan","admin123","fa-hayyan");
} else {
	$koneksi = new mysqli("localhost","customer_fa-hayyan","customer123","fa-hayyan");
}

if (mysqli_connect_errno()) {
	printf("Connect failed: %s\n", mysqli_connect_error());
	exit();
}
?>