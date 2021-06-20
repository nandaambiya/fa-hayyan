<?php

session_start();
include 'koneksi.php';

$ambil = $koneksi->query("SELECT * FROM produk_satuan_barang WHERE id_satuan_barang='$_GET[id]'");
$data = $ambil->fetch_assoc();

$koneksi->query("DELETE FROM produk_satuan_barang WHERE id_satuan_barang='$_GET[id]'");

echo "<script>alert('Satuan Barang Berhasil Dihapus!');</script>";
echo "<script>location='index.php?halaman=satuan_barang';</script>";

?>