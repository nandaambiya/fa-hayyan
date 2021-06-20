<?php
	session_start();
	
	include 'koneksi.php';

	$id = $_GET['id'];

	$koneksi->query("DELETE FROM produk_jenis WHERE id_produk_jenis = '$id'");

	echo "<script>window.history.back();</script>";

?>