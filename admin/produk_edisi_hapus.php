<?php

include 'koneksi.php';

$ambil = $koneksi->query("SELECT * FROM kategori_produk_edisi WHERE id_edisi='$_GET[id]'");
$data = $ambil->fetch_assoc();
$foto1 = $data['foto_masker'];
$foto2 = $data['foto_scrunchie'];

$cekdataproduk = 0;

$ambilwarna = $koneksi->query("SELECT * FROM kategori_warna_produk WHERE id_edisi='$_GET[id]'");
$cekdatawarna = $ambilwarna->num_rows;

while($ambilwarnadata = $ambilwarna->fetch_assoc()){

	$ambilproduk = $koneksi->query("SELECT * FROM produk WHERE id_warna = '$ambilwarnadata[id_warna]'");

	while ($ambilproduk->fetch_assoc()) {
		$cekdataproduk++;
	}
}

if($cekdataproduk > 0) {
	echo "<script>alert('Edisi gagal dihapus! Harap hapus setiap produk yang menggunakan variasi warna pada edisi ini terlebih dahulu!');</script>";
	echo "<script>window.history.back();</script>";
}
else{
	if (!empty($foto1) && file_exists("../edisi/$foto1")){
		unlink("../edisi/$foto1");
	}

	if (!empty($foto2) && file_exists("../edisi/$foto2")) {
		unlink("../edisi/$foto2");
	}

	$koneksi->query("DELETE FROM kategori_warna_produk WHERE id_edisi='$_GET[id]'");

	$koneksi->query("DELETE FROM kategori_produk_edisi WHERE id_edisi='$_GET[id]'");

	echo "<script>alert('Edisi Dihapus!');</script>";
	echo "<script>location='index.php?halaman=produk_edisi';</script>";
}
?>