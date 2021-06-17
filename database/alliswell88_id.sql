-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2021 at 04:03 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `alliswell88.id`
--

-- --------------------------------------------------------

--
-- Table structure for table `akun`
--

CREATE TABLE `akun` (
  `id_akun` int(5) NOT NULL,
  `email` varchar(65) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `kode_pos` varchar(5) NOT NULL,
  `no_hp` varchar(20) NOT NULL,
  `type_user` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `akun`
--

INSERT INTO `akun` (`id_akun`, `email`, `password`, `nama`, `alamat`, `kode_pos`, `no_hp`, `type_user`) VALUES
(1, 'alliswell88id@gmail.com', 'admin123', 'Admin', '-', '', '-', 1),
(2, 'arsyfgdrive@gmail.com', '654321', 'Arsya Fikri', 'Jl. Medan-Binjai km. 13,5, Medan Sunggal, Sumatera Utara', '20127', '082212347896', 2),
(3, 'arsya@mail.com', '123456', 'Arsya Fikri', '', '', '082275809719', 2),
(4, 'arsya@email.com', '123456', 'Arsya Fikri', '', '', '0812457868', 2),
(5, 'email@tes.com', '123456', 'Testing', '', '', '123456789', 2),
(6, 'a@c.c', '123456', 'sdasdas', '', '', '5265165115', 2),
(7, 'm@a.f', '123456', 'Arsya', 'Jl. Medan-Binjai', '20127', '87884546484', 2);

-- --------------------------------------------------------

--
-- Table structure for table `kategori_produk_edisi`
--

CREATE TABLE `kategori_produk_edisi` (
  `id_edisi` int(2) NOT NULL,
  `edisi` varchar(15) NOT NULL,
  `foto_masker` varchar(100) NOT NULL,
  `foto_scrunchie` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori_produk_edisi`
--

INSERT INTO `kategori_produk_edisi` (`id_edisi`, `edisi`, `foto_masker`, `foto_scrunchie`) VALUES
(1, 'Spunbond', 'spunbond-mask.png', ''),
(2, 'Linen', 'linen-mask.png', ''),
(3, 'Satin', 'satin-mask.png', 'Satin-scrunchie.png'),
(4, 'Katun', 'katun-mask.png', 'Katun-scrunchie.png'),
(5, 'Emboss', 'emboss-mask.png', ''),
(6, 'Tie Dye', 'tie-dye-mask.png', 'Tie-dye-scrunchie.png'),
(7, 'Batik', 'batik-mask.png', ''),
(8, 'Christmas', 'christmas-mask.png', 'Christmas-scrunchie.png'),
(9, 'Crepe', '', 'Crepe-scrunchie.png'),
(10, 'Silky', 'silky-mask.png', ''),
(11, 'Cotton', '', 'Katun-scrunchie.png');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_produk_jenis`
--

CREATE TABLE `kategori_produk_jenis` (
  `id_jenis` int(11) NOT NULL,
  `jenis` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori_produk_jenis`
--

INSERT INTO `kategori_produk_jenis` (`id_jenis`, `jenis`) VALUES
(1, 'Masker'),
(2, 'Scrunchie - Biasa'),
(3, 'Scrunchie - Zipper');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_warna_produk`
--

CREATE TABLE `kategori_warna_produk` (
  `id_warna` int(3) NOT NULL,
  `id_edisi` int(2) NOT NULL,
  `warna` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori_warna_produk`
--

INSERT INTO `kategori_warna_produk` (`id_warna`, `id_edisi`, `warna`) VALUES
(1, 1, 'Black Jet'),
(2, 1, 'Creme'),
(3, 1, 'Gray'),
(4, 1, 'White'),
(5, 1, 'Brown'),
(6, 1, 'Lime Green'),
(7, 1, 'Pink'),
(8, 1, 'Tosca'),
(9, 1, 'Blue Navy'),
(10, 1, 'Dodger Blue'),
(11, 1, 'Fanta'),
(12, 1, 'Light Blue'),
(13, 1, 'Dark Green'),
(14, 1, 'Red'),
(15, 2, 'Brown Sugar'),
(16, 2, 'Dark Tosca'),
(17, 2, 'Ash Grey'),
(18, 3, 'White Klamby'),
(19, 3, 'Red Klamby'),
(20, 3, 'Purple Klamby'),
(21, 3, 'Lilac'),
(22, 3, 'Dusty Rose'),
(23, 3, 'Gold'),
(24, 3, 'Greenmint'),
(25, 4, 'Baby Blue'),
(26, 4, 'Dusty Rose'),
(27, 4, 'Broken White'),
(28, 4, 'Soft Army'),
(29, 4, 'White'),
(30, 4, 'Black'),
(31, 4, 'Plum'),
(32, 4, 'Terracota'),
(33, 5, 'Gold'),
(34, 5, 'Silver'),
(35, 6, 'Cloudy'),
(36, 6, 'Coffee Beige'),
(37, 6, 'Blue Root'),
(38, 6, 'Mud Black'),
(39, 6, 'Santorini Blue'),
(40, 6, 'Berry Plum'),
(41, 6, 'Fine Chocolate'),
(42, 6, 'Sky Blue'),
(43, 6, 'Pineapple Tone'),
(44, 6, 'Black White'),
(45, 6, 'Colourful'),
(46, 7, 'Monochrome'),
(47, 7, 'Gold'),
(48, 7, 'Red'),
(49, 7, 'Brownie'),
(50, 8, 'Red Ginger'),
(51, 8, 'Red Snowball'),
(52, 8, 'Green Ginger'),
(53, 8, 'White Snow'),
(54, 9, 'Navy'),
(55, 9, 'Maroon'),
(56, 9, 'Black'),
(57, 9, 'Baby Blue'),
(58, 10, 'Navy'),
(59, 10, 'Maroon'),
(60, 11, 'Black'),
(61, 11, 'Plum'),
(62, 11, 'Terracota'),
(63, 11, 'White');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(5) NOT NULL,
  `id_pesanan` int(5) NOT NULL,
  `nama_pembayar` varchar(50) NOT NULL,
  `metode_bayar` varchar(40) NOT NULL,
  `tanggal` varchar(12) NOT NULL,
  `bukti_pembayaran` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_pesanan`, `nama_pembayar`, `metode_bayar`, `tanggal`, `bukti_pembayaran`) VALUES
(1, 5, 'Fikri', 'OVO', '30-12-2020', '30122020150855_nopem_5_25122019192019_nopem_2_tes123_images.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id_pesanan` int(5) NOT NULL,
  `id_akun` int(5) NOT NULL,
  `tanggal_pesan` varchar(12) NOT NULL,
  `subtotal_produk` int(9) NOT NULL,
  `alamat_kirim` text NOT NULL,
  `opsi_pengiriman` varchar(50) NOT NULL,
  `subtotal_pengiriman` int(9) NOT NULL,
  `status_pesanan` varchar(50) NOT NULL DEFAULT 'Menunggu Pembayaran',
  `resi_pengiriman` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id_pesanan`, `id_akun`, `tanggal_pesan`, `subtotal_produk`, `alamat_kirim`, `opsi_pengiriman`, `subtotal_pengiriman`, `status_pesanan`, `resi_pengiriman`) VALUES
(1, 2, '30-12-2020', 48000, 'Jl. Medan-Binjai km. 13,5, Medan Sunggal, Sumatera Utara, Kota , 20127', '', 0, 'Menunggu Pembayaran', ''),
(2, 2, '30-12-2020', 20000, 'Jl. Medan-Binjai km. 13,5, Medan Sunggal, Sumatera Utara, Kota , 20127', '', 0, 'Menunggu Pembayaran', ''),
(3, 2, '30-12-2020', 0, 'Jl. Medan-Binjai km. 13,5, Medan Sunggal, Sumatera Utara, Kota , 20127', '', 0, 'Menunggu Pembayaran', ''),
(4, 2, '30-12-2020', 16000, 'Jl. Medan-Binjai km. 13,5, Medan Sunggal, Sumatera Utara, Kota Medan, Sumatera Utara, 20127', 'Jalur Nugraha Ekakurir (JNE), REG', 10000, 'Menunggu Pembayaran', ''),
(5, 2, '30-12-2020', 20000, 'Jl. Medan-Binjai km. 13,5, Medan Sunggal, Sumatera Utara, Kota Medan, Sumatera Utara, 20127', 'Citra Van Titipan Kilat (TIKI), REG', 7000, 'Menunggu Pembayaran', 'JP123789456');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan_produk`
--

CREATE TABLE `pesanan_produk` (
  `id_pesanan` int(5) NOT NULL,
  `id_produk` int(5) NOT NULL,
  `jumlah_pesanan` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pesanan_produk`
--

INSERT INTO `pesanan_produk` (`id_pesanan`, `id_produk`, `jumlah_pesanan`) VALUES
(1, 11, 3),
(1, 6, 1),
(2, 16, 1),
(2, 13, 1),
(4, 16, 1),
(4, 7, 1),
(5, 7, 1),
(5, 12, 1);

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(5) NOT NULL,
  `id_jenis` int(5) NOT NULL,
  `id_warna` int(3) NOT NULL,
  `nama_produk` varchar(100) NOT NULL,
  `harga_produk` int(10) NOT NULL,
  `foto_produk` varchar(200) NOT NULL,
  `deskripsi_produk` text NOT NULL,
  `stok_produk` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `id_jenis`, `id_warna`, `nama_produk`, `harga_produk`, `foto_produk`, `deskripsi_produk`, `stok_produk`) VALUES
(1, 1, 15, 'Masker Kain Katun Linen 2 ply - Brown Sugar', 7500, 'linen-mask-brown-sugar.png', 'Fabric : Katun Linen + Katun Import Jepang\r\nSize : 17 x 13 cm\r\nReady Stock no Pre-Order\r\n-\r\n> Earloop\r\n> Tidak ada lubang tisu\r\n> Karet dapat disesuaikan sendiri (free stopper)\r\n> Tersedia juga dalam model dewasa earloop dan headloop\r\n> Pilihan Motif lain silahkan check di etalase\r\n> Dipacking 1 plastik ziplock/item\r\n-\r\nMOHON DIPERHATIKAN :\r\nProduk ini merupakan mass produk sehingga kemungkinan terdapat perbedaan 1-2cm dari size yang tertera.', 32),
(2, 1, 17, 'Masker Kain Katun Linen 2 ply - Ash Grey', 7500, 'linen-mask-ash-grey.png', 'Fabric : Katun Linen + Katun Import Jepang <br>\r\nSize : 17 x 13 cm <br>\r\nReady Stock no Pre-Order <br>\r\n- <br>\r\n> Earloop<br>\r\n> Tidak ada lubang tisu<br>\r\n> Karet dapat disesuaikan sendiri (free stopper)<br>\r\n> Tersedia juga dalam model dewasa earloop dan headloop<br>\r\n> Pilihan Motif lain silahkan check di etalase<br>\r\n> Dipacking 1 plastik ziplock/item<br>\r\n-<br>\r\nMOHON DIPERHATIKAN :<br>\r\nProduk ini merupakan mass produk sehingga kemungkinan terdapat perbedaan 1-2cm dari size yang tertera.', 32),
(3, 1, 16, 'Masker Kain Katun Linen 2 ply - Dark Tosca', 7500, 'linen-mask-dark-tosca.png', 'Fabric : Katun Linen + Katun Import Jepang\r\nSize : 17 x 13 cm\r\nReady Stock no Pre-Order\r\n-\r\n> Earloop\r\n> Tidak ada lubang tisu\r\n> Karet dapat disesuaikan sendiri (free stopper)\r\n> Tersedia juga dalam model dewasa earloop dan headloop\r\n> Pilihan Motif lain silahkan check di etalase\r\n> Dipacking 1 plastik ziplock/item\r\n-\r\nMOHON DIPERHATIKAN :\r\nProduk ini merupakan mass produk sehingga kemungkinan terdapat perbedaan 1-2cm dari size yang tertera.', 32),
(4, 1, 21, 'Masker Kain Satin 2 ply - Lilac', 12000, 'satin-mask-lilac-2.png', 'Fabric : Satin + Katun Import Jepang\r\nSize : 17 x 13 cm\r\nReady Stock no Pre-Order\r\n-\r\n> Earloop\r\n> Tidak ada lubang tisu\r\n> Karet dapat disesuaikan sendiri (free stopper)\r\n> Tersedia juga dalam model dewasa earloop dan headloop\r\n> Pilihan Motif lain silahkan check di etalase\r\n> Dipacking 1 plastik ziplock/item\r\n-\r\nMOHON DIPERHATIKAN :\r\nProduk ini merupakan mass produk sehingga kemungkinan terdapat perbedaan 1-2cm dari size yang tertera.', 23),
(5, 1, 33, 'Masker Kain Satin Emboss 2 ply - Gold', 12000, 'emboss-mask-gold.png', 'Fabric : Satin Emboss Glitter + Katun Import Jepang\r\nSize : 17 x 13 cm\r\nReady Stock no Pre-Order\r\n-\r\n> Earloop\r\n> Tidak ada lubang tisu\r\n> Karet dapat disesuaikan sendiri (free stopper)\r\n> Tersedia juga dalam model dewasa earloop dan headloop\r\n> Pilihan Motif lain silahkan check di etalase\r\n> Dipacking 1 plastik ziplock/item\r\n-\r\nMOHON DIPERHATIKAN :\r\nProduk ini merupakan mass produk sehingga kemungkinan terdapat perbedaan 1-2cm dari size yang tertera.', 21),
(6, 1, 34, 'Masker Kain Satin Emboss 2 ply - Silver', 12000, 'emboss-mask-silver.png', 'Fabric : Satin Emboss Glitter + Katun Import Jepang\r\nSize : 17 x 13 cm\r\nReady Stock no Pre-Order\r\n-\r\n> Earloop\r\n> Tidak ada lubang tisu\r\n> Karet dapat disesuaikan sendiri (free stopper)\r\n> Tersedia juga dalam model dewasa earloop dan headloop\r\n> Pilihan Motif lain silahkan check di etalase\r\n> Dipacking 1 plastik ziplock/item\r\n-\r\nMOHON DIPERHATIKAN :\r\nProduk ini merupakan mass produk sehingga kemungkinan terdapat perbedaan 1-2cm dari size yang tertera.', 19),
(7, 2, 56, 'Ikat Rambut Scrunchie Crepe - Black', 8000, 'crepe-scrunchie-black.png', 'Fabric : Diamond Crepe\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction & Breakage).\r\n', 2),
(9, 1, 8, 'Masker Kain Spunbond 2 ply - Tosca', 2500, 'spunbond-mask-Tosca.png', 'Bahan Spunbond 2 lapis (sesuai di foto)\r\nBahan nyaman dipakai\r\nDipacking dengan plastik ziplock\r\nJahitan Rapi Rapat Kuat\r\nSangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau\r\nDapat di cuci dan di gunakan kembali\r\nWarna dikirim sesuai pilihan variant', 795),
(10, 1, 26, 'Masker Kain Katun 2 ply - Dusty Rose', 12000, 'cotton-mask-dusty-rose.png', 'Fabric : Cotton Import Jepang\r\nReady Stock no Pre-Order\r\n\r\nEarloop\r\nTidak ada lubang tisu\r\nKaret dapat disesuaikan sendiri (free stopper)\r\nTersedia juga dalam model dewasa earloop dan headloop\r\nPilihan Motif lain silahkan check di etalase\r\nDi packing 1 plastik ziplock/item', 8),
(11, 1, 36, 'Masker Kain Tie Dye 2 ply - Coffee Beige', 12000, 'tie-dye-mask-coffee-beige.png', 'Fabric : Tie Dye Rayon Janger + Katun Import Jepang\r\nReady Stock no Pre-Order\r\n\r\nEarloop\r\nTidak ada lubang tisu\r\nKaret dapat disesuaikan sendiri (free stopper)\r\nTersedia juga dalam model dewasa earloop dan headloop\r\nPilihan Motif lain silahkan check di etalase\r\nDi packing 1 plastik ziplock/item', 8),
(12, 1, 48, 'Masker Kain Batik 2 ply - Red', 12000, 'batik-mask-Red-Bata.png', 'Fabric : Batik Sandwos + Katun Import Jepang\r\nReady Stock no Pre-Order\r\n\r\nEarloop\r\nTidak ada lubang tisu\r\nKaret dapat disesuaikan sendiri (free stopper)\r\nTersedia juga dalam model dewasa earloop dan headloop\r\nPilihan Motif lain silahkan check di etalase\r\nDi packing 1 plastik ziplock/item', 13),
(13, 1, 50, 'Masker Kain Christmas 2 ply - Red Ginger', 12000, 'christmas-mask-red-ginger.png', 'Fabric : Katun Import Jepang\r\nReady Stock no Pre-Order\r\n\r\nEarloop\r\nTidak ada lubang tisu\r\nKaret dapat disesuaikan sendiri (free stopper)\r\nTersedia juga dalam model dewasa earloop dan headloop\r\nPilihan Motif lain silahkan check di etalase\r\nDi packing 1 plastik ziplock/item', 12),
(14, 1, 59, 'Masker Kain Silky 2 ply - Maroon', 12000, 'silky-mask-maroon.png', 'Fabric : Satin Jaguar + Katun Import Jepang\r\nReady Stock no Pre-Order\r\n\r\nEarloop\r\nTidak ada lubang tisu\r\nKaret dapat disesuaikan sendiri (free stopper)\r\nTersedia juga dalam model dewasa earloop dan headloop\r\nPilihan Motif lain silahkan check di etalase\r\nDi packing 1 plastik ziplock/item', 32),
(15, 3, 55, 'Ikat Rambut Scrunchie Crepe Zipper - Maroon', 12000, 'crepe-scrunchie-maroon.png', 'Fabric : Diamond Crepe\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction & Breakage).', 4),
(16, 2, 55, 'Ikat Rambut Scrunchie Crepe - Maroon', 8000, 'crepe-scrunchie-maroon.png', 'Fabric : Diamond Crepe\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction & Breakage).', 2),
(17, 2, 57, 'Ikat Rambut Scrunchie Crepe - Baby Blue', 8000, 'crepe-scrunchie-baby-blue.png', '<p>Fabric : Diamond Crepe<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 5),
(18, 3, 57, 'Ikat Rambut Scrunchie Crepe - Baby Blue', 12000, 'crepe-scrunchie-baby-blue.png', '<p>Fabric : Diamond Crepe<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 5),
(19, 2, 54, 'Ikat Rambut Scrunchie Crepe - Navy', 8000, 'crepe-scrunchie-navy.png', '<p>Fabric : Diamond Crepe<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 4),
(20, 3, 54, 'Ikat Rambut Scrunchie Crepe - Navy', 12000, 'crepe-scrunchie-navy.png', '<p>Fabric : Diamond Crepe<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 4),
(21, 2, 60, 'Ikat Rambut Scrunchie Katun - Black', 11000, 'cotton-scrunchie-black.png', '<p>Fabric : Cotton<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 6),
(22, 1, 25, 'Masker Kain Katun 2 ply - Baby Blue', 12000, 'cotton-mask-baby-blue.png', '<p>Fabric : Cotton Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 19),
(23, 1, 18, 'Masker Kain Satin 2 ply - White Klamby', 12000, 'satin-klamby-mask-white-klamby-2.png', '<p>Fabric : Satin + Katun Import Jepang Size : 17 x 13 cm Ready Stock no Pre-Order - &gt; Earloop &gt; Tidak ada lubang tisu &gt; Karet dapat disesuaikan sendiri (free stopper) &gt; Tersedia juga dalam model dewasa earloop dan headloop &gt; Pilihan Motif lain silahkan check di etalase &gt; Dipacking 1 plastik ziplock/item - MOHON DIPERHATIKAN : Produk ini merupakan mass produk sehingga kemungkinan terdapat perbedaan 1-2cm dari size yang tertera.</p>\r\n', 3),
(24, 1, 38, 'Masker Kain Tie Dye 2 ply - Mud Black', 12000, 'tie-dye-mask-mud-black.png', '<p>Fabric : Tie Dye Rayon Janger + Katun Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 4),
(25, 1, 35, 'Masker Kain Tie Dye 2 ply - Cloudy', 12000, 'tie-dye-mask-cloudy.png', '<p>Fabric : Tie Dye Rayon Janger + Katun Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 1),
(26, 1, 37, 'Masker Kain Tie Dye 2 ply - Blue Root', 12000, 'tie-dye-mask-blue-root.png', '<p>Fabric : Tie Dye Rayon Janger + Katun Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 6),
(27, 1, 49, 'Masker Kain Batik 2 ply - Brownie', 12000, 'batik-mask-Brownie.png', '<p>Fabric : Batik Sandwos + Katun Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 15),
(28, 1, 47, 'Masker Kain Batik 2 ply - Gold', 12000, 'batik-mask-Gold.png', '<p>Fabric : Batik Sandwos + Katun Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 2),
(29, 1, 46, 'Masker Kain Batik 2 ply - Monochrome', 12000, 'batik-mask-Monochrome.png', '<p>Fabric : Batik Sandwos + Katun Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 5),
(30, 1, 52, 'Masker Kain Christmas 2 ply - Green Ginger', 12000, 'christmas-mask-green-ginger-2.png', '<p>Fabric : Katun Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 6),
(31, 1, 53, 'Masker Kain Christmas 2 ply - White Snow', 12000, 'christmas-mask-white-snow.png', '<p>Fabric : Katun Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 5),
(32, 1, 51, 'Masker Kain Christmas 2 ply - Red Snowball', 12000, 'christmas-mask-red-snow-ball.png', '<p>Fabric : Katun Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 14),
(33, 1, 58, 'Masker Kain Silky 2 ply - Navy', 12000, 'silky-mask-navy.png', '<p>Fabric : Satin Jaguar + Katun Import Jepang Ready Stock no Pre-Order Earloop Tidak ada lubang tisu Karet dapat disesuaikan sendiri (free stopper) Tersedia juga dalam model dewasa earloop dan headloop Pilihan Motif lain silahkan check di etalase Di packing 1 plastik ziplock/item</p>\r\n', 32),
(34, 1, 1, 'Masker Kain Spunbond 2 ply - Black Jet', 2500, 'spunbond-mask-Black-Jet.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 5),
(35, 1, 9, 'Masker Kain Spunbond 2 ply - Blue Navy', 2500, 'spunbond-mask-Blue-Navy.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 0),
(36, 1, 5, 'Masker Kain Spunbond 2 ply - Brown', 2500, 'spunbond-mask-Brown.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 0),
(37, 1, 2, 'Masker Kain Spunbond 2 ply - Creme', 2500, 'spunbond-mask-Creme.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 0),
(38, 1, 13, 'Masker Kain Spunbond 2 ply - Dark Green', 2500, 'spunbond-mask-Dark-Green.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 0),
(39, 1, 10, 'Masker Kain Spunbond 2 ply - Dodger Blue', 2500, 'spunbond-mask-Dodger-Blue.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 0),
(40, 1, 11, 'Masker Kain Spunbond 2 ply - Fanta', 2500, 'spunbond-mask-Fanta.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 0),
(41, 1, 3, 'Masker Kain Spunbond 2 ply - Gray', 2500, 'spunbond-mask-Gray.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 0),
(42, 1, 12, 'Masker Kain Spunbond 2 ply - Light Blue', 2500, 'spunbond-mask-Light-Blue.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 2),
(43, 1, 6, 'Masker Kain Spunbond 2 ply - Lime Green', 2500, 'spunbond-mask-Lime-Green.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 10),
(44, 1, 7, 'Masker Kain Spunbond 2 ply - Pink', 2500, 'spunbond-mask-Pink.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 1),
(45, 1, 14, 'Masker Kain Spunbond 2 ply - Red', 2500, 'spunbond-mask-Red.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 4),
(46, 1, 4, 'Masker Kain Spunbond 2 ply - White', 2500, 'spunbond-mask-White.png', '<p>Bahan Spunbond 2 lapis (sesuai di foto) Bahan nyaman dipakai Dipacking dengan plastik ziplock Jahitan Rapi Rapat Kuat Sangat Cocok untuk di pakai sendiri maupun kegiatan sosial karena harga sangat terjangkau Dapat di cuci dan di gunakan kembali Warna dikirim sesuai pilihan variant</p>\r\n', 2),
(47, 3, 60, 'Ikat Rambut Scrunchie Katun - Black', 15000, 'cotton-scrunchie-black.png', '<p>Fabric : Cotton<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 21),
(48, 2, 61, 'Ikat Rambut Scrunchie Katun - Plum', 11000, 'cotton-scrunchie-plum.png', '<p>Fabric : Cotton<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 9),
(49, 3, 61, 'Ikat Rambut Scrunchie Katun - Plum', 15000, 'cotton-scrunchie-plum.png', '<p>Fabric : Cotton<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 8),
(50, 2, 62, 'Ikat Rambut Scrunchie Katun - Terracota', 11000, 'cotton-scrunchie-terracota.png', '<p>Fabric : Cotton<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 16),
(51, 3, 62, 'Ikat Rambut Scrunchie Katun - Terracota', 15000, 'cotton-scrunchie-terracota.png', '<p>Fabric : Cotton<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 21),
(52, 2, 63, 'Ikat Rambut Scrunchie Katun - White', 11000, 'cotton-scrunchie-white.png', '<p>Fabric : Cotton<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 15),
(53, 3, 63, 'Ikat Rambut Scrunchie Katun - White', 15000, 'cotton-scrunchie-white.png', '<p>Fabric : Cotton<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 1),
(54, 2, 52, 'Ikat Rambut Scrunchie Christmas - Green Ginger', 14000, 'christmas-scrunchie-green-ginger.png', '<p>Fabric : Cotton / Katun Import<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 1),
(55, 3, 52, 'Ikat Rambut Scrunchie Christmas - Green Ginger', 14000, 'christmas-scrunchie-green-ginger.png', '<p>Fabric : Cotton / Katun Import<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 1),
(57, 3, 50, 'Ikat Rambut Scrunchie Christmas - Red Ginger', 14000, 'christmas-scrunchie-red-ginger-2.png', '<p>Fabric : Cotton / Katun Import<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 5),
(58, 2, 50, 'Ikat Rambut Scrunchie Christmas - Red Ginger', 14000, 'christmas-scrunchie-red-ginger-2.png', '<p>Fabric : Cotton / Katun Import<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 4),
(59, 2, 53, 'Ikat Rambut Scrunchie Christmas - White Snow', 14000, 'christmas-scrunchie-white-snow.png', '<p>Fabric : Cotton / Katun Import<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 6),
(60, 3, 53, 'Ikat Rambut Scrunchie Christmas - White Snow', 14000, 'christmas-scrunchie-white-snow.png', '<p>Fabric : Cotton / Katun Import<br />\r\nSize : approx 12 cm<br />\r\nHarga tertera adalah harga satuan<br />\r\nDipacking satuan dengan plastik ziplock</p>\r\n\r\n<p>Nyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).</p>\r\n', 5),
(61, 2, 19, 'Ikat Rambut Scrunchie Satin - Red Klamby', 9000, 'satin-klamby-scrunchie-red-klamby.png', 'Fabric : Satin Klamby Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 4),
(62, 3, 19, 'Ikat Rambut Scrunchie Satin - Red Klamby', 13000, 'satin-klamby-scrunchie-red-klamby.png', 'Fabric : Satin Klamby Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 6),
(63, 3, 18, 'Ikat Rambut Scrunchie Satin - White Klamby', 13000, 'satin-klamby-scrunchie-white-klamby.png', 'Fabric : Satin Klamby Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 7),
(64, 2, 18, 'Ikat Rambut Scrunchie Satin - White Klamby', 9000, 'satin-klamby-scrunchie-white-klamby.png', 'Fabric : Satin Klamby Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 8),
(65, 2, 22, 'Ikat Rambut Scrunchie Satin - Dusty Rose', 9000, 'satin-scrunchie-dusty-rose.png', 'Fabric : Satin Velvet Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\\\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 9),
(66, 3, 22, 'Ikat Rambut Scrunchie Satin - Dusty Rose', 13000, 'satin-scrunchie-dusty-rose.png', 'Fabric : Satin Velvet Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\\\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 10),
(67, 2, 23, 'Ikat Rambut Scrunchie Satin - Gold', 9000, 'satin-scrunchie-gold.png', 'Fabric : Satin Velvet Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\\\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 15),
(68, 3, 23, 'Ikat Rambut Scrunchie Satin - Gold', 13000, 'satin-scrunchie-gold.png', 'Fabric : Satin Velvet Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\\\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 11),
(69, 2, 24, 'Ikat Rambut Scrunchie Satin - Greenmint', 9000, 'satin-scrunchie-greenmint.png', 'Fabric : Satin Velvet Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\\\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 26),
(70, 3, 24, 'Ikat Rambut Scrunchie Satin - Greenmint', 13000, 'satin-scrunchie-greenmint.png', 'Fabric : Satin Velvet Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\\\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 1),
(71, 2, 21, 'Ikat Rambut Scrunchie Satin - Lilac', 9000, 'satin-scrunchie-lilac.png', 'Fabric : Satin Velvet Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\\\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 14),
(72, 3, 21, 'Ikat Rambut Scrunchie Satin - Lilac', 13000, 'satin-scrunchie-lilac.png', 'Fabric : Satin Velvet Premium Lembut\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\\\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 2),
(73, 2, 40, 'Ikat Rambut Scrunchie Tie Dye - Berry Plum', 9000, 'tie-dye-scrunchie-berry-plum.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).\r\n', 9),
(74, 3, 40, 'Ikat Rambut Scrunchie Tie Dye - Berry Plum', 13000, 'tie-dye-scrunchie-berry-plum.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).\r\n', 3),
(75, 2, 44, 'Ikat Rambut Scrunchie Tie Dye - Black White', 9000, 'tie-dye-scrunchie-Black-White-2.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).\r\n', 5),
(76, 3, 44, 'Ikat Rambut Scrunchie Tie Dye - Black White', 13000, 'tie-dye-scrunchie-Black-White-2.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).\r\n', 8),
(77, 2, 41, 'Ikat Rambut Scrunchie Tie Dye - Fine Chocolate', 9000, 'tie-dye-scrunchie-fine-chocolate.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).\r\n', 10),
(78, 3, 41, 'Ikat Rambut Scrunchie Tie Dye - Fine Chocolate', 13000, 'tie-dye-scrunchie-fine-chocolate.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).\r\n', 4),
(79, 2, 43, 'Ikat Rambut Scrunchie Tie Dye - Pineapple Tone', 9000, 'tie-dye-scrunchie-pineapple-tone.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).\r\n', 7),
(80, 3, 43, 'Ikat Rambut Scrunchie Tie Dye - Pineapple Tone', 13000, 'tie-dye-scrunchie-pineapple-tone.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).\r\n', 9),
(81, 2, 39, 'Ikat Rambut Scrunchie Tie Dye - Santorini Blue', 9000, 'tie-dye-scrunchie-santorini-blue.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 16),
(82, 3, 39, 'Ikat Rambut Scrunchie Tie Dye - Santorini Blue', 13000, 'tie-dye-scrunchie-santorini-blue.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 18),
(83, 2, 42, 'Ikat Rambut Scrunchie Tie Dye - Sky Blue', 9000, 'tie-dye-scrunchie-sky-blue.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 3),
(84, 3, 42, 'Ikat Rambut Scrunchie Tie Dye - Sky Blue', 13000, 'tie-dye-scrunchie-sky-blue.png', 'Fabric : Rayon Janger Handmade Original from Denpasar, Bali\r\nSize : approx 12 cm\r\nHarga tertera adalah harga satuan\r\nDipacking satuan dengan plastik ziplock\r\n\r\nNyaman dipakai, ringan, jahitan rapi dan karet kuat (Less Hair Friction &amp; Breakage).', 20),
(85, 1, 18, 'Masker Kain Satin 2 ply - White Klamby', 12000, 'satin-klamby-mask-white-klamby-3.png', '<p>Fabric : Satin + Katun Import Jepang Size : 17 x 13 cm Ready Stock no Pre-Order - &gt; Earloop &gt; Tidak ada lubang tisu &gt; Karet dapat disesuaikan sendiri (free stopper) &gt; Tersedia juga dalam model dewasa earloop dan headloop &gt; Pilihan Motif lain silahkan check di etalase &gt; Dipacking 1 plastik ziplock/item - MOHON DIPERHATIKAN : Produk ini merupakan mass produk sehingga kemungkinan terdapat perbedaan 1-2cm dari size yang tertera.</p>\r\n', 4),
(86, 1, 18, 'Masker Kain Satin 2 ply - White Klamby', 12000, 'satin-klamby-mask-white-klamby-4.png', '<p>Fabric : Satin + Katun Import Jepang Size : 17 x 13 cm Ready Stock no Pre-Order - &gt; Earloop &gt; Tidak ada lubang tisu &gt; Karet dapat disesuaikan sendiri (free stopper) &gt; Tersedia juga dalam model dewasa earloop dan headloop &gt; Pilihan Motif lain silahkan check di etalase &gt; Dipacking 1 plastik ziplock/item - MOHON DIPERHATIKAN : Produk ini merupakan mass produk sehingga kemungkinan terdapat perbedaan 1-2cm dari size yang tertera.</p>\r\n', 9);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akun`
--
ALTER TABLE `akun`
  ADD PRIMARY KEY (`id_akun`);

--
-- Indexes for table `kategori_produk_edisi`
--
ALTER TABLE `kategori_produk_edisi`
  ADD PRIMARY KEY (`id_edisi`);

--
-- Indexes for table `kategori_produk_jenis`
--
ALTER TABLE `kategori_produk_jenis`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indexes for table `kategori_warna_produk`
--
ALTER TABLE `kategori_warna_produk`
  ADD PRIMARY KEY (`id_warna`),
  ADD KEY `id_edisi` (`id_edisi`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id_pesanan`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`),
  ADD KEY `id_jenis` (`id_jenis`),
  ADD KEY `id_warna` (`id_warna`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `akun`
--
ALTER TABLE `akun`
  MODIFY `id_akun` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `kategori_produk_edisi`
--
ALTER TABLE `kategori_produk_edisi`
  MODIFY `id_edisi` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `kategori_produk_jenis`
--
ALTER TABLE `kategori_produk_jenis`
  MODIFY `id_jenis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kategori_warna_produk`
--
ALTER TABLE `kategori_warna_produk`
  MODIFY `id_warna` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id_pesanan` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kategori_warna_produk`
--
ALTER TABLE `kategori_warna_produk`
  ADD CONSTRAINT `kategori_warna_produk_ibfk_1` FOREIGN KEY (`id_edisi`) REFERENCES `kategori_produk_edisi` (`id_edisi`);

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`id_warna`) REFERENCES `kategori_warna_produk` (`id_warna`),
  ADD CONSTRAINT `produk_ibfk_2` FOREIGN KEY (`id_jenis`) REFERENCES `kategori_produk_jenis` (`id_jenis`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
