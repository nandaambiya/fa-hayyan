<?php

include 'koneksi.php';

$ambil = $koneksi->query("SELECT * FROM produk WHERE id_produk='$_GET[id]'");
$data = $ambil->fetch_assoc();
$foto = $data['foto_produk'];

if (file_exists("../image/produk/$foto"))
{
	unlink("../image/$foto");
}


$koneksi->query("DELETE FROM produk WHERE id_produk='$_GET[id]'");

echo "<script>alert('Barang Dihapus!');</script>";
echo "<script>location='index.php?halaman=produk';</script>";

?>