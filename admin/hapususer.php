<?php 
$uname = $_GET['username'];

$koneksi->query("DELETE FROM akun WHERE username='$uname'");

echo "<script>alert('Data Akun Dihapus!');</script>";
echo "<script>location='index.php?halaman=user';</script>";
?>