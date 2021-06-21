<?php 
session_start();

include 'koneksi.php';

$id_akun = $_GET['id'];

$koneksi->query("DELETE FROM akun WHERE id_akun='$id_akun'");

echo "<script>alert('Data Akun Dihapus!');</script>";
echo "<script>location='index.php?halaman=user';</script>";
?>