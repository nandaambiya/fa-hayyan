<?php

session_start();
include 'koneksi.php';

$ambil = $koneksi->query("SELECT * FROM produk_satuan_ukuran WHERE id_satuan_ukuran='$_GET[id]'");
$data = $ambil->fetch_assoc();

$koneksi->query("DELETE FROM produk_satuan_ukuran WHERE id_satuan_ukuran='$_GET[id]'");

echo "<script>alert('Satuan Ukuran Berhasil Dihapus!');</script>";
echo "<script>location='index.php?halaman=satuan_ukuran';</script>";

?>