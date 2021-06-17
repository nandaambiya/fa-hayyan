<?php

include 'koneksi.php';

$ambilwarna = $koneksi->query("SELECT * FROM kategori_warna_produk WHERE id_warna='$_GET[id]'")->fetch_assoc();

$ambilproduk = $koneksi->query("SELECT * FROM produk WHERE id_warna = '$ambilwarna[id_warna]'");

$cekdataproduk = $ambilproduk->num_rows;

echo $cekdataproduk;

if($cekdataproduk > 0) {
	echo "<script>alert('Warna gagal dihapus dikarenakan ada produk dengan variasi warna ini. Harap hapus produk tersebut terlebih dahulu!');</script>";
	echo "<script>window.history.back();</script>";
}
else{
	$koneksi->query("DELETE FROM kategori_warna_produk WHERE id_warna='$_GET[id]'");

	echo "<script>alert('Warna Dihapus!');</script>";
	echo "<script>location='index.php?halaman=produk_edisi';</script>";
}
?>