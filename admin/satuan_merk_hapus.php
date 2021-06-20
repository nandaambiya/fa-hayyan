<?php

session_start();
include 'koneksi.php';

$ambil = $koneksi->query("SELECT * FROM produk_merk WHERE id_merk='$_GET[id]'");
$data = $ambil->fetch_assoc();

$koneksi->query("DELETE FROM produk_merk WHERE id_merk='$_GET[id]'");

echo "<script>alert('Merk Berhasil Dihapus!');</script>";
echo "<script>location='index.php?halaman=satuan_merk';</script>";

?>