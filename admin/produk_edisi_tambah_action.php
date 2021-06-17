<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<?php

include 'koneksi.php';

if (!empty($_FILES['foto_masker']['name']) OR !empty($_FILES['foto_scrunchie']['name'])) {
	$namafoto_m = $_FILES['foto_masker']['name'];
	$lokasisementarafoto_m = $_FILES['foto_masker']['tmp_name'];

	$namafoto_s = $_FILES['foto_scrunchie']['name'];
	$lokasisementarafoto_s = $_FILES['foto_scrunchie']['tmp_name'];

	if (!empty($lokasisementarafoto_m) && empty($lokasisementarafoto_s)) {
		move_uploaded_file($lokasisementarafoto_m, "../edisi/".$namafoto_m);

		$koneksi->query("INSERT INTO kategori_produk_edisi (edisi, foto_masker) VALUES ('$_POST[nama]', '$namafoto_m')");

		echo "<script>alert('Data Disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk_edisi';</script>";
	}

	elseif (empty($lokasisementarafoto_m) && !empty($lokasisementarafoto_s)) {
		move_uploaded_file($lokasisementarafoto_s, "../edisi/".$namafoto_s);

		$koneksi->query("INSERT INTO kategori_produk_edisi (edisi, foto_scrunchie) VALUES ('$_POST[nama]', '$namafoto_s')");

		echo "<script>alert('Data Disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk_edisi';</script>";
	}

	elseif (!empty($lokasisementarafoto_m) && !empty($lokasisementarafoto_s)) {
		move_uploaded_file($lokasisementarafoto_m, "../edisi/".$namafoto_m);
		move_uploaded_file($lokasisementarafoto_s, "../edisi/".$namafoto_s);

		$koneksi->query("INSERT INTO kategori_produk_edisi (edisi, foto_masker, foto_scrunchie) VALUES ('$_POST[nama]', '$namafoto_m', '$namafoto_s')");

		echo "<script>alert('Data Disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk_edisi';</script>";
	}
}
else{
	echo "<script>alert('Data gagal disimpan! Upload setidaknya satu foto thumbnail');</script>";
	echo "<script>location='index.php?halaman=produk_edisi_tambah';</script>";
}

?>