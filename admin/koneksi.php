<?php
// $koneksi = new mysqli("localhost","root","","alliswell88.id");
if (isset($_SESSION['admin'])) {
	$koneksi = mysqli_connect("localhost","admin_fa-hayyan","admin123","fa-hayyan");
} else {
	$koneksi = mysqli_connect("localhost","customer_fa-hayyan","customer123","fa-hayyan");
}

if (mysqli_connect_errno()) {
	printf("Connect failed: %s\n", mysqli_connect_error());
	exit();
}
?>