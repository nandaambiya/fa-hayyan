<?php
session_start();

include 'koneksi.php';

$id_produk = $_GET['id'];

$ambil = $koneksi->query("SELECT gambar FROM produk WHERE id_produk='$id_produk'");
$data = $ambil->fetch_assoc();
$foto = $data['gambar'];

if (file_exists("../image/produk/$foto"))
{
	unlink("../image/$foto");
}


$koneksi->query("DELETE FROM produk WHERE id_produk='$id_produk'");

echo "<script>alert('Barang Dihapus!');</script>";
echo "<script>location='index.php?halaman=produk';</script>";

?>