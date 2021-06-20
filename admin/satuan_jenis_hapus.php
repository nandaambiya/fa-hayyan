<?php

session_start();
include 'koneksi.php';

$ambil = $koneksi->query("SELECT * FROM jenis_produk WHERE id_jenis='$_GET[id]'");
$data = $ambil->fetch_assoc();

$koneksi->query("DELETE FROM jenis_produk WHERE id_jenis='$_GET[id]'");

echo "<script>alert('Jenis Berhasil Dihapus!');</script>";
echo "<script>location='index.php?halaman=satuan_jenis';</script>";

?>