-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 21, 2021 at 01:38 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fa-hayyan`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cariProduk` (IN `kywrd` VARCHAR(255))  NO SQL
BEGIN
SELECT
    *
FROM
    `listproduk`
WHERE
    nama LIKE CONCAT('%', kywrd, '%')
    OR merk LIKE CONCAT('%', kywrd, '%')
    OR harga LIKE CONCAT('%', kywrd, '%')
    OR satuan_barang LIKE CONCAT('%', kywrd, '%')
    OR jenis LIKE CONCAT('%', kywrd, '%')
    OR deskripsi LIKE CONCAT('%', kywrd, '%')
    AND stok > 0
GROUP BY
	id_produk;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_harga_total` (`id_prdk` INT(4), `jmlh` INT(4)) RETURNS INT(11) NO SQL
BEGIN
	DECLARE hrg INT;
	SELECT harga INTO hrg FROM produk WHERE id_produk = id_prdk;
    
    RETURN hrg * jmlh;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `akun`
--

CREATE TABLE `akun` (
  `id_akun` int(5) NOT NULL,
  `user_db` int(1) NOT NULL,
  `email` varchar(320) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` text NOT NULL,
  `kode_pos` char(5) NOT NULL,
  `no_hp` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `akun`
--

INSERT INTO `akun` (`id_akun`, `user_db`, `email`, `password`, `nama`, `alamat`, `kode_pos`, `no_hp`) VALUES
(1, 1, 'admin@email.com', 'admin123', 'Admin', '-', '-', '081234567890'),
(2, 2, 'arsya@example.com', '123456789', 'Arsya', 'Jalan Medan Binjai km 13,5, Jl. Setia I, Gg. Keluarga Dusun VII', '20351', '082275801234'),
(3, 2, 'arsyfpro@email.com', '123456789', 'Arsya Pro', 'Jl. Medan-Binjai km 13,5', '20355', '081234567890'),
(4, 2, 'anda@anda.com', '123456789', 'Anda Melinda', 'Jalan Kasuari No 78', '20352', '0812784565'),
(7, 2, 'email@email.com', '123456789', 'Fikri', 'Jalan Medan-Binjai', '20351', '08122130254');

--
-- Triggers `akun`
--
DELIMITER $$
CREATE TRIGGER `cek_duplikat_email_insert` BEFORE INSERT ON `akun` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT 1 FROM akun WHERE email = NEW.email)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'INSERT gagal dikarenkan terdapat duplikasi data';
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cek_duplikat_email_update` BEFORE UPDATE ON `akun` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT 1 FROM akun WHERE email = NEW.email)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'UPDATE gagal dikarenkan terdapat duplikasi data';
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `check_kode_pos_no_hp` BEFORE INSERT ON `akun` FOR EACH ROW BEGIN
	IF (NEW.kode_pos REGEXP '^[0-9]*$' = 0 OR NEW.no_hp REGEXP '^[0-9]*$' = 0) THEN
    SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Kode Pos dan Nomor HP harus berupa angka!';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `check_update_kode_pos_no_hp` BEFORE UPDATE ON `akun` FOR EACH ROW BEGIN
	IF (NEW.kode_pos REGEXP '^[0-9]*$' = 0 OR NEW.no_hp REGEXP '^[0-9]*$' = 0) THEN
    SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Kode Pos dan Nomor HP harus berupa angka!';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_log_update_profil` BEFORE UPDATE ON `akun` FOR EACH ROW BEGIN
INSERT INTO log_edit_profil
SET id_akun = OLD.id_akun,
nama_baru = new.nama,
nama_lama = old.nama,
alamat_baru = new.alamat,
alamat_lama = old.alamat,
kode_pos_baru = new.kode_pos,
kode_pos_lama = old.kode_pos,
no_hp_baru = new.no_hp,
no_hp_lama = old.no_hp,
waktu = date_format(now(),'%d-%m-%Y %H:%i:%s');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `akun_db`
--

CREATE TABLE `akun_db` (
  `id_akun_db` int(1) NOT NULL,
  `akun` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `akun_db`
--

INSERT INTO `akun_db` (`id_akun_db`, `akun`, `username`, `password`) VALUES
(1, 'admin fa-hayyan', 'admin_fa-hayyan', 'admin123'),
(2, 'customer fa-hayyan', 'customer_fa-hayyan', 'customer123');

-- --------------------------------------------------------

--
-- Stand-in structure for view `detail_user_pesanan`
-- (See below for the actual view)
--
CREATE TABLE `detail_user_pesanan` (
`id_pesanan` int(5)
,`id_akun` int(5)
,`tanggal` char(10)
,`nama` varchar(50)
,`no_hp` varchar(15)
,`email` varchar(320)
,`alamat` text
,`ongkos_kirim` int(10)
,`opsi_kirim` varchar(100)
,`status` enum('Belum Dibayar','Dibayar','Dikirim','Dibatalkan','Pembayaran Invalid')
,`resi_pengiriman` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `jenis_produk`
--

CREATE TABLE `jenis_produk` (
  `id_jenis` int(3) NOT NULL,
  `jenis` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jenis_produk`
--

INSERT INTO `jenis_produk` (`id_jenis`, `jenis`) VALUES
(1, 'Obat Kumur'),
(2, 'Obat Bebas Terbatas'),
(3, 'Obat Keras'),
(4, 'Salep'),
(6, 'Obat Batuk'),
(7, 'susu'),
(8, 'Obat bebas'),
(9, 'Obat maag'),
(10, 'Obat sakit kepala'),
(11, 'Obat demam'),
(12, 'Obat penambah darah'),
(13, 'Obat sakit perut'),
(14, 'Obat herbal');

--
-- Triggers `jenis_produk`
--
DELIMITER $$
CREATE TRIGGER `cek_duplikat_jenis_insert` BEFORE INSERT ON `jenis_produk` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT 1 FROM jenis_produk WHERE jenis = NEW.jenis)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'INSERT gagal dikarenkan terdapat duplikasi data';
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cek_duplikat_jenis_update` BEFORE UPDATE ON `jenis_produk` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT 1 FROM jenis_produk WHERE jenis = NEW.jenis)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'UPDATE gagal dikarenkan terdapat duplikasi data';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `listpesanan`
-- (See below for the actual view)
--
CREATE TABLE `listpesanan` (
`id_akun` int(5)
,`id_pesanan` int(5)
,`tanggal` char(10)
,`status` enum('Belum Dibayar','Dibayar','Dikirim','Dibatalkan','Pembayaran Invalid')
,`total_bayar` decimal(33,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `listproduk`
-- (See below for the actual view)
--
CREATE TABLE `listproduk` (
`id_produk` int(4)
,`nama` varchar(300)
,`merk` varchar(50)
,`harga` int(8)
,`ukuran` int(6)
,`satuan_ukuran` varchar(20)
,`stok` int(4)
,`terakhir_diubah` char(19)
,`satuan_barang` varchar(20)
,`jenis` varchar(50)
,`deskripsi` text
,`gambar` text
);

-- --------------------------------------------------------

--
-- Table structure for table `log_edit_profil`
--

CREATE TABLE `log_edit_profil` (
  `id_log_edit_profil` int(5) NOT NULL,
  `id_akun` int(5) NOT NULL,
  `nama_lama` varchar(50) NOT NULL,
  `nama_baru` varchar(50) NOT NULL,
  `alamat_lama` text NOT NULL,
  `alamat_baru` text NOT NULL,
  `kode_pos_lama` char(5) NOT NULL,
  `kode_pos_baru` char(5) NOT NULL,
  `no_hp_lama` varchar(15) NOT NULL,
  `no_hp_baru` varchar(15) NOT NULL,
  `waktu` char(19) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_edit_profil`
--

INSERT INTO `log_edit_profil` (`id_log_edit_profil`, `id_akun`, `nama_lama`, `nama_baru`, `alamat_lama`, `alamat_baru`, `kode_pos_lama`, `kode_pos_baru`, `no_hp_lama`, `no_hp_baru`, `waktu`) VALUES
(1, 2, 'Arsya Fikri', 'Arsya', 'Jalan Medan Binjai km 13,5', 'Jalan Medan Binjai km 13,5, Jl. Setia I, Gg. Keluarga Dusun VII', '20351', '20351', '082275801234', '082275801234', '18-06-2021 23:34:12'),
(2, 3, 'Arsya Pro', 'Arsya Pro', 'Jl. Johor Baru Medan Johor', 'Jl. Medan-Binjai km 13,5', '20351', '20351', '081234567890', '081234567890', '19-06-2021 01:20:00'),
(3, 3, 'Arsya Pro', 'Arsya Pro', 'Jl. Medan-Binjai km 13,5', 'Jl. Medan-Binjai km 13,5', '20351', '20355', '081234567890', '081234567890', '20-06-2021 02:27:08'),
(4, 4, 'Anda Putra', 'Anda Melinda', 'Jalan Kasuari No 69', 'Jalan Kasuari No 78', '20321', '20351', '081234578955', '081234572547', '20-06-2021 03:00:50'),
(7, 4, 'Anda Melinda', 'Anda Melinda', 'Jalan Kasuari No 78', 'Jalan Kasuari No 78', '20351', '20352', '081234572547', '081234572547', '20-06-2021 15:44:55'),
(9, 4, 'Anda Melinda', 'Anda Melinda', 'Jalan Kasuari No 78', 'Jalan Kasuari No 78', '20352', '20352', '081234572547', '0812784565', '20-06-2021 15:45:10');

-- --------------------------------------------------------

--
-- Table structure for table `log_produk_stok`
--

CREATE TABLE `log_produk_stok` (
  `id_log_produk_stok` int(10) NOT NULL,
  `id_produk` int(4) NOT NULL,
  `aksi` enum('Penambahan','Pengurangan','Stok Baru') NOT NULL,
  `stok_lama` int(4) NOT NULL,
  `stok_baru` int(4) NOT NULL,
  `timestamp` char(19) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_produk_stok`
--

INSERT INTO `log_produk_stok` (`id_log_produk_stok`, `id_produk`, `aksi`, `stok_lama`, `stok_baru`, `timestamp`) VALUES
(17, 2, 'Penambahan', 12, 15, '18-06-2021 17:43:16'),
(18, 2, 'Pengurangan', 15, 14, '18-06-2021 18:17:02'),
(19, 1, 'Pengurangan', 22, 21, '18-06-2021 18:17:02'),
(20, 1, 'Penambahan', 21, 25, '18-06-2021 18:33:47'),
(21, 3, '', 0, 20, '18-06-2021 19:16:32'),
(22, 3, 'Pengurangan', 20, 0, '18-06-2021 19:16:56'),
(23, 3, 'Penambahan', 0, 3, '18-06-2021 20:17:45'),
(24, 1, 'Pengurangan', 25, 24, '19-06-2021 02:48:17'),
(25, 3, 'Pengurangan', 3, 2, '19-06-2021 02:58:37'),
(26, 1, 'Pengurangan', 24, 23, '20-06-2021 02:43:06'),
(27, 3, 'Pengurangan', 2, 0, '20-06-2021 02:43:06'),
(28, 2, 'Pengurangan', 14, 13, '20-06-2021 02:57:10'),
(35, 1, 'Penambahan', 23, 26, '20-06-2021 20:53:10'),
(36, 1, 'Penambahan', 26, 30, '20-06-2021 20:54:01'),
(37, 1, 'Penambahan', 30, 31, '20-06-2021 20:57:34'),
(38, 12, 'Stok Baru', 0, 5, '21-06-2021 12:54:35'),
(39, 12, 'Pengurangan', 5, 3, '21-06-2021 12:58:27'),
(40, 13, 'Stok Baru', 0, 3, '21-06-2021 14:05:06'),
(41, 14, 'Stok Baru', 0, 10, '21-06-2021 14:47:52'),
(43, 13, 'Penambahan', 3, 13, '21-06-2021 14:49:35'),
(44, 15, 'Stok Baru', 0, 10, '21-06-2021 14:54:44'),
(45, 16, 'Stok Baru', 0, 10, '21-06-2021 15:23:50'),
(46, 17, 'Stok Baru', 0, 10, '21-06-2021 15:29:43'),
(47, 18, 'Stok Baru', 0, 10, '21-06-2021 15:38:18'),
(48, 19, 'Stok Baru', 0, 10, '21-06-2021 15:49:43'),
(49, 20, 'Stok Baru', 0, 10, '21-06-2021 15:54:18'),
(50, 21, 'Stok Baru', 0, 10, '21-06-2021 15:59:21'),
(51, 22, 'Stok Baru', 0, 10, '21-06-2021 16:01:43'),
(52, 23, 'Stok Baru', 0, 10, '21-06-2021 16:06:42'),
(53, 24, 'Stok Baru', 0, 8, '21-06-2021 16:17:25'),
(54, 25, 'Stok Baru', 0, 8, '21-06-2021 16:21:47'),
(55, 26, 'Stok Baru', 0, 8, '21-06-2021 16:24:21'),
(56, 27, 'Stok Baru', 0, 10, '21-06-2021 17:12:34'),
(57, 28, 'Stok Baru', 0, 10, '21-06-2021 17:16:22'),
(58, 29, 'Stok Baru', 0, 10, '21-06-2021 17:18:45'),
(59, 30, 'Stok Baru', 0, 10, '21-06-2021 17:21:02'),
(60, 31, 'Stok Baru', 0, 10, '21-06-2021 17:23:24'),
(61, 32, 'Stok Baru', 0, 10, '21-06-2021 17:25:36'),
(62, 33, 'Stok Baru', 0, 10, '21-06-2021 17:28:33'),
(63, 34, 'Stok Baru', 0, 10, '21-06-2021 17:32:22'),
(64, 35, 'Stok Baru', 0, 20, '21-06-2021 17:39:29'),
(65, 36, 'Stok Baru', 0, 20, '21-06-2021 17:44:05'),
(66, 37, 'Stok Baru', 0, 20, '21-06-2021 17:50:25'),
(67, 38, 'Stok Baru', 0, 20, '21-06-2021 17:52:58'),
(68, 39, 'Stok Baru', 0, 10, '21-06-2021 17:55:49'),
(69, 40, 'Stok Baru', 0, 10, '21-06-2021 18:03:34'),
(70, 41, 'Stok Baru', 0, 10, '21-06-2021 18:20:12'),
(71, 42, 'Stok Baru', 0, 10, '21-06-2021 18:22:42'),
(72, 43, 'Stok Baru', 0, 10, '21-06-2021 18:24:33'),
(73, 44, 'Stok Baru', 0, 12, '21-06-2021 18:27:36'),
(74, 45, 'Stok Baru', 0, 12, '21-06-2021 18:29:13'),
(75, 46, 'Stok Baru', 0, 5, '21-06-2021 18:30:45'),
(76, 47, 'Stok Baru', 0, 12, '21-06-2021 18:33:05'),
(77, 48, 'Stok Baru', 0, 12, '21-06-2021 18:34:16');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(6) NOT NULL,
  `id_pesanan` int(5) NOT NULL,
  `pembayar` varchar(50) NOT NULL,
  `tanggal` char(10) NOT NULL,
  `metode` enum('BNI','OVO','Dana','Gopay') NOT NULL,
  `bukti` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_pesanan`, `pembayar`, `tanggal`, `metode`, `bukti`) VALUES
(1, 2, 'Ilham', '19-06-2021', 'OVO', '19062021162609_nopem_2_4e0b8f4dccd1d54255060000.jpg'),
(2, 4, 'Fendi', '19-06-2021', 'Gopay', '19062021220710_nopem_4_4e0b8f4dccd1d54255060000.jpg'),
(3, 5, 'Melinda', '19-06-2021', 'Dana', '19062021215737_nopem_5_typesofinheritance.jpg'),
(4, 6, 'arsya', '21-06-2021', 'BNI', '21062021075859_nopem_6_sepatuadidas4.jpg');

-- --------------------------------------------------------

--
-- Stand-in structure for view `pembayaran_pesanan`
-- (See below for the actual view)
--
CREATE TABLE `pembayaran_pesanan` (
`id_pembayaran` int(6)
,`id_pesanan` int(5)
,`pembayar` varchar(50)
,`tanggal` char(10)
,`metode` enum('BNI','OVO','Dana','Gopay')
,`bukti` text
,`status` enum('Belum Dibayar','Dibayar','Dikirim','Dibatalkan','Pembayaran Invalid')
,`resi_pengiriman` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id_pesanan` int(5) NOT NULL,
  `id_akun` int(5) NOT NULL,
  `tanggal` char(10) NOT NULL,
  `alamat` text NOT NULL,
  `opsi_kirim` varchar(100) NOT NULL,
  `ongkos_kirim` int(10) NOT NULL,
  `status` enum('Belum Dibayar','Dibayar','Dikirim','Dibatalkan','Pembayaran Invalid') NOT NULL DEFAULT 'Belum Dibayar',
  `resi_pengiriman` varchar(50) NOT NULL DEFAULT '-'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id_pesanan`, `id_akun`, `tanggal`, `alamat`, `opsi_kirim`, `ongkos_kirim`, `status`, `resi_pengiriman`) VALUES
(1, 2, '18-06-2021', 'Jalan Medan Binjai km 13,5', 'JNE', 7000, 'Belum Dibayar', '-'),
(2, 3, '18-06-2021', 'Jl. Medan-Binjai km 13,5, Kota Medan, Sumatera Utara, 20351', 'Jalur Nugraha Ekakurir (JNE), CTC', 7000, 'Pembayaran Invalid', '-'),
(3, 3, '19-06-2021', 'Jl. Medan-Binjai km 13,5, Kota Medan, Sumatera Utara, 20351', 'Jalur Nugraha Ekakurir (JNE), CTC', 7000, 'Pembayaran Invalid', '-'),
(4, 4, '20-06-2021', 'Jalan Kasuari No 69, Kota Aceh Barat Daya, Nanggroe Aceh Darussalam (NAD), 20321', 'Jalur Nugraha Ekakurir (JNE), REG', 27000, 'Pembayaran Invalid', '-'),
(5, 4, '20-06-2021', 'Jalan Kasuari No 69, Kota Aceh Barat Daya, Nanggroe Aceh Darussalam (NAD), 20321', 'Jalur Nugraha Ekakurir (JNE), REG', 27000, 'Belum Dibayar', '-'),
(6, 2, '21-06-2021', 'Jalan Medan Binjai km 13,5, Jl. Setia I, Gg. Keluarga Dusun VII, Kota Binjai, Sumatera Utara, 20351', 'Jalur Nugraha Ekakurir (JNE), YES', 15000, 'Dikirim', '-342564747');

-- --------------------------------------------------------

--
-- Stand-in structure for view `pesananproduk`
-- (See below for the actual view)
--
CREATE TABLE `pesananproduk` (
`id_pesanan` int(5)
,`nama` varchar(300)
,`harga` int(8)
,`jumlah_beli` int(4)
,`total` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `pesanan_detail`
--

CREATE TABLE `pesanan_detail` (
  `id_detail_pesanan` int(6) NOT NULL,
  `id_pesanan` int(5) NOT NULL,
  `id_produk` int(4) NOT NULL,
  `jumlah_beli` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pesanan_detail`
--

INSERT INTO `pesanan_detail` (`id_detail_pesanan`, `id_pesanan`, `id_produk`, `jumlah_beli`) VALUES
(5, 1, 2, 1),
(6, 1, 1, 3),
(7, 2, 1, 1),
(8, 3, 3, 1),
(9, 4, 1, 1),
(10, 4, 3, 2),
(11, 5, 2, 1),
(12, 6, 12, 2);

--
-- Triggers `pesanan_detail`
--
DELIMITER $$
CREATE TRIGGER `update_stok_pesanan` AFTER INSERT ON `pesanan_detail` FOR EACH ROW BEGIN
UPDATE produk_stok SET stok = stok-NEW.jumlah_beli WHERE id_produk = NEW.id_produk;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(4) NOT NULL,
  `id_merk` int(4) NOT NULL,
  `nama` varchar(300) NOT NULL,
  `harga` int(8) NOT NULL,
  `ukuran` int(6) NOT NULL,
  `satuan_ukuran` int(2) NOT NULL,
  `satuan_barang` int(4) NOT NULL,
  `deskripsi` text NOT NULL,
  `gambar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `id_merk`, `nama`, `harga`, `ukuran`, `satuan_ukuran`, `satuan_barang`, `deskripsi`, `gambar`) VALUES
(1, 1, 'BETADINE GARGLE 190 ML', 32000, 190, 1, 1, '<p>asdas23234dasd</p>\r\n', '20062021155856_produk_download.jpg'),
(2, 1, 'BETADINE GARGLE 100 ML', 17000, 100, 1, 1, 'Obat kumur antiseptik untuk rongga mulut seperti gigi berlubang, gusi bengkak, sakit tenggorokan, sariawan, bau mulut dan nafas tak segar', 'apotek_online_k24klik_201904291011331242_BETADINE.jpg'),
(3, 1, 'BETADINE OINT 20 GR', 30000, 20, 2, 2, 'Salep luka yang dapat digunakan untuk luka terbuka maupun luka bakar.', 'apotek_online_k24klik_20200711015219359225_BETADIN-20G-1.jpg'),
(12, 7, 'Kid Zee Chocolate 350g', 44000, 350, 2, 3, '<p>Kid Zee Chocolate merupakan susu untuk anak dengan rasa coklat yang diproduksi oleh PT. Kalbe Farma. Kid Zee Chocolate mengandung omega 3:6, kolin, prebiotik dan tinggi kalsium. Kolin memiliki peran membentuk fosfatidilkolin yang berperan penting bagi membran sel, prebiotik mempertahankan fungsi pada saluran cerna, serta kalsium yang tinggi berperan dalam peembentukan tulang dan kepadatan tulang dan gigi.<br />\r\nIndikasi / Manfaat / Kegunaan :<br />\r\nmemberikan nutrisi untuk anak dan membantu memadatkan tulang dan gigi<br />\r\nDosis<br />\r\n2 gelas per hari<br />\r\nPerhatian<br />\r\ntidak cocok untuk anak dibawah 1 tahun. jangan simpan pada lemari pendingin.</p>\r\n', '21062021075435_produk_kid-zee-chocolate-350g.png'),
(13, 9, 'DECOLGEN 4 tab', 3000, 3, 2, 4, '<p>Decolgen merupakan obat untuk meringankan gejala flu seperti demam, sakit kepala, hidung tersumbat dan bersin-bersin.</p>\r\n\r\n<p>Setiap 1 tablet Decolgen mengandung:</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; Paracetamol (Acetaminophen) adalah zat aktif yang memiliki aktivitas sebagai penurun demam/antipiretik dan pereda nyeri/analgesik yang bisa diperoleh tanpa resep dokter.</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; Chlorpheniramine maleate (CTM) adalah zat aktif yang digunakan untuk mengobati &nbsp;gejala alergi seperti rhinitis dan urtikaria. Termasuk dalam golongan antihistamin generasi pertama yang memiliki efek sedatif rendah.</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; Phenylpropalamine HCl adalah zat aktif yang berfungsi sebagai stimulan dan nasal dekongestan (untuk mengatasi pilek dan hidung tersumbat).<br />\r\nIndikasi / Manfaat / Kegunaan :<br />\r\nmeredakan gejala flu : sakit kepala, demam, bersin-bersin dan hidung tersumbat<br />\r\nSub Kategori<br />\r\nObat Batuk dan Pilek<br />\r\nTag<br />\r\nflu , influenza , demam , sakit kepala , hidung tersumbat , bersin-bersin<br />\r\nKomposisi<br />\r\nparasetamol 400 mg, fenilpropanolamin 12.5 mg, ctm 1 mg<br />\r\nDosis<br />\r\n3 x 1 tablet<br />\r\nPenyajian<br />\r\nsesudah makan<br />\r\nCara Penyimpanan<br />\r\nsimpan di tempat sejuk dan kering, terhindar dari paparan sinar matahari langsung<br />\r\nPerhatian<br />\r\nhipersensitivitas komponen, penderita hipertensi, gangguan jantung dan diabetes melitus, gangguan fungsi hati berat<br />\r\nEfek Samping<br />\r\nmengantuk, ganguan pencernaan, insomnia, gelisah, eksitasi,tremor, takikardi,aritmia, mulut kering, sulit berkemih, penggunaan dosis besar dan jangka panjang menyebabkan kerusakan hati.<br />\r\nKemasan<br />\r\n1 Dos isi 25 Strip<br />\r\nNama Standar MIMS<br />\r\nDECOLGEN TAB STR 4&#39;S<br />\r\nGolongan Obat<br />\r\nobat bebas terbatas Obat Bebas Terbatas</p>\r\n', '21062021090506_produk_DECOLGEN.jpg'),
(14, 10, 'Bebelac 3 vanilla 400g', 65000, 400, 2, 3, '<p>&bull; SUSU PERTUMBUHAN BEBELAC 3: dengan minyak ikan dan omega 6 lebih tinggi</p>\r\n\r\n<p>&bull; BARU LEBIH LEZAT: dengan berbagai pilihan rasa yang lezat</p>\r\n\r\n<p>&bull; NUTRISI PENTING: Minyak ikan, Omega 3, Omega 6, FOS:GOS 1:9, 13 Vitamin &amp; 9 Mineral</p>\r\n\r\n<p>&bull; SUSU PERTUMBUHAN ANAK: Usia 1-3 tahun&nbsp;</p>\r\n\r\n<p>Indikasi / Manfaat / Kegunaan :<br />\r\nSUSU PERTUMBUHAN ANAK: Usia 1-3 tahun &nbsp;<br />\r\nSub Kategori<br />\r\nProduk Nutrisi Bayi<br />\r\nTag<br />\r\nsusu<br />\r\nKomposisi<br />\r\nMinyak ikan, Omega 3, Omega 6 Bebelac dibuat dengan minyak ikan (0.26%) dan mengandung Asam a-linolenat (Omega 3) 107 mg/saji dan Asam linoleat (Omega 6) 1205 mg/saji. -FOS:GOS 1:9 -13 Vitamin &amp; 9 Mineral Dengan kandungan Zat Besi, Zinc, Iodium, Vitamin A, dan Kalsium untuk pertumbuhan yang optimal.</p>\r\n\r\n<p>&nbsp;<br />\r\nPenyajian<br />\r\nJumlah per Sajian :</p>\r\n\r\n<p>Takaran saji: 3 sendok takar(39g/235 ml)</p>\r\n\r\n<p>Standar pengenceran:&nbsp;</p>\r\n\r\n<p>235 ml Bebelac 3</p>\r\n\r\n<p>=200 ml air hangat + 3 sendok takar</p>\r\n\r\n<p>1 sendok takar = 13 g</p>\r\n\r\n<p>&nbsp;<br />\r\nPerhatian<br />\r\nTidak cocok untuk bayi dibawah usia 12 Bulan.</p>\r\n', '21062021094752_produk_BEBELAC-3.jpg'),
(15, 8, 'Anlene gold plus vanilla 175 g', 35000, 175, 2, 3, '<p>Produk Nutrisi Parenteral</p>\r\n\r\n<p>Kemasan<br />\r\n1 Pcs<br />\r\nNama Standar&nbsp;<br />\r\nANLENE GOLD PLUS VANILA 175G BOX<br />\r\n<br />\r\nPabrik<br />\r\nFonterra<br />\r\n<br />\r\nGolongan Obat<br />\r\nobat bebas Obat Bebas</p>\r\n', '21062021095444_produk_ANLENE-GOLD-PLUS.jpg'),
(16, 11, 'Dancow 5+ coklat 800g', 86000, 800, 2, 3, '<p>DANCOW Advanced Excelnutri+ 5+ adalah susu untuk anak usia 5-12 tahun yang merupakan inovasi terbaru dari Nestle Research Centre. Dengan kandungan lebih dari 3X Lactobacillus rhamnosus di bandingkan produk sebelumnya.</p>\r\n\r\n<p>Produk Nutrisi /Enteral</p>\r\n\r\n<p>Kemasan<br />\r\n1 Dos<br />\r\nNama Standar MIMS<br />\r\nDANCOW 5+ COKLAT 800G</p>\r\n', '21062021102350_produk_DANCOW-5--COKLAT-800G.jpg'),
(17, 12, 'Diabetasol vita digest van 185g', 45000, 185, 2, 3, '<p>susu khusus untuk penderita diabetes<br />\r\nIndikasi / Manfaat / Kegunaan :<br />\r\nsusu untuk membantu mengatur kadar glukosa darah pada diabetisi bila disertai dengan konsumsi rendah gula dan gizi seimbang<br />\r\nSub Kategori<br />\r\nProduk Nutrisi /Enteral</p>\r\n\r\n<p>Komposisi<br />\r\nlemak, protein, karbohidrat, natrium, vitamin, asam folat, kalsium, besi, fosfor, magnesium, zinc, yodium<br />\r\nDosis<br />\r\ndiminum setiap hari<br />\r\nPenyajian<br />\r\n4 sendok takar dilarutkan dalam 200 ml air matang<br />\r\nKemasan<br />\r\n1 Pcs<br />\r\nNama Standar MIMS<br />\r\nDIABETASOL VITA DIGEST VAN 185G</p>\r\n', '21062021102943_produk_DIABETASOL-VITA-DIGEST-VAN-180G-2.jpg'),
(18, 13, 'Entrasol gold vanilla 175g', 35000, 175, 2, 3, '<p>Entrasol Gold merupakan susu yang diformulasikan untuk usia 51 tahun ke atas agar tetap sehat dan aktif.</p>\r\n\r\n<p>Indikasi / Manfaat / Kegunaan :<br />\r\nuntuk usia 51 tahun ke atas agar tetap sehat dan aktif.<br />\r\nSub Kategori<br />\r\nProduk Nutrisi /Enteral</p>\r\n\r\n<p>Komposisi<br />\r\nHi Calcium, omega 3&amp;6, vitamin, dan mineral<br />\r\nDosis<br />\r\nSesuai kebutuhan<br />\r\nPenyajian<br />\r\nSeperti pada penyajian susu biasa<br />\r\nCara Penyimpanan<br />\r\nsimpan di tempat yang sejuk dan kering, serta terlindung dari sinar matahari langsung<br />\r\nKemasan<br />\r\n1 Pcs</p>\r\n', '21062021103818_produk_ENTRASOL-GOLD-VANILA-185G-2.jpg'),
(19, 14, 'Lactogen 1 preboitik 180g', 33000, 180, 2, 3, '<p><strong>LACTOGEN 1</strong>&nbsp;merupakan susu formula yang diformulasi khusus bagi bayi usia 0-6 bulan untuk membantu tahap awal pertumbuhan anak. Susu formula ini mengandung&nbsp;<strong>Probiotik</strong>, LA dan ALA, serta Zat Besi, dan diperkaya dengan 12 Vitamin dan 11 mineral serta kandungan protein.</p>\r\n\r\n<p>Produk Nutrisi Bayi</p>\r\n\r\n<p>Kemasan<br />\r\n1 Pcs<br />\r\nNama Standar MIMS<br />\r\nLACTOGEN 1 PREBOITIK G/F 180G</p>\r\n', '21062021104942_produk_LACTOGEN-1-180G.jpg'),
(20, 16, 'SGM ananda 0-6 bln 150g', 15000, 150, 2, 3, '<p>SGM ANANDA 0-6BLN 400G BOX merupakan susu formula yang digunakan untuk bayi usia 0 &ndash; 6 bulan untuk melengkapi nutrisi penting yang dibutuhkan, memiliki kandungan:<br />\r\nPadatan susu (protein whey, laktosa)<br />\r\nMinyak nabati (mengandung lesitin kedelai, antioksidan askorbil palmitat dan campuran tokoferol)<br />\r\nMaltodekstrin<br />\r\nSusu bubuk skim<br />\r\nFOS-inulin<br />\r\nPremiks vitamin dan mineral<br />\r\nAA (mengandung antioksidan tokoferol dan askorbil palmitat)&nbsp;<br />\r\nDHA (mengandung antioksidan tokoferol).</p>\r\n\r\n<p>Siapkan larutan hanya untuk satu kali pemberian dan diberikan langsung setelah disiapkan. Buang larutan yang tersisa setelah 2 jam. Penggunaan formula untuk bayi hanya atas rekomendasi Dokter. ASI adalah yang terbaik.&nbsp;</p>\r\n\r\n<p>Indikasi / Manfaat / Kegunaan :<br />\r\nSusu formula untuk bayi usia 0 &ndash; 6 bulan.&nbsp;<br />\r\nSub Kategori<br />\r\nProduk Nutrisi Bayi</p>\r\n\r\n<p>Komposisi<br />\r\nPadatan susu (protein whey, laktosa)<br />\r\nMinyak nabati (mengandung lesitin kedelai, antioksidan askorbil palmitat dan campuran tokoferol)<br />\r\nMaltodekstrin<br />\r\nSusu bubuk skim<br />\r\nFOS-inulin<br />\r\nPremiks vitamin dan mineral<br />\r\nAA (mengandung antioksidan tokoferol dan askorbil palmitat)<br />\r\nDHA (mengandung antioksidan tokoferol). &nbsp;<br />\r\nDosis<br />\r\nDisesuaikan dengan petunjuk dokter atau sesuai dengan kemasan produk susu.&nbsp;<br />\r\nPenyajian<br />\r\nSiapkan larutan hanya untuk satu kali pemberian dan diberikan langsung setelah disiapkan. Buang larutan yang tersisa setelah 2 jam&nbsp;<br />\r\nCara Penyimpanan<br />\r\nSetelah dibuka, lipat kantung sachet susu formula bayi beberapa kali. Simpan kantung sachet susu formula untuk bayi baru lahir dan sendok takar dalam wadah kering, bersih, sejuk dan tertutup rapat tidak lebih dari 1 (satu) bulan. Jangan diberikan pada bayi Anda, jika terjadi perubahan warna, bau, dan rasa dari bubuk susu. Susu yang bagus untuk bayi adalah susu yang tidak mengalami perubahan warna, bau, dan rasa dari bubuk susu. &nbsp;<br />\r\nPerhatian<br />\r\nPemakaian SGM ANANDA 0-6BLN 400G BOX atas nasehat Dokter.&nbsp;<br />\r\nPerhatian petunjuk penyiapan, penggunaan dan penyimpanan.&nbsp;<br />\r\nKemasan<br />\r\n1 Pcs</p>\r\n', '21062021105416_produk_SGM-Ananda-150g.png'),
(21, 16, 'SGM eksplor 1 plus vanilla 150g', 15000, 150, 2, 3, '<p>SGM EKSPLOR 1 PLUS VANILLA 150G&nbsp;merupakan susu pertumbuhan untuk anak usia 1 - 3 tahun&nbsp;untuk melengkapi nutrisi penting yang dibutuhkan,&nbsp;agar si kecil dapat menjadi anak generasi maju yang supel, kreatif dan mandiri.&nbsp;</p>\r\n\r\n<p>SGM EKSPLOR 1 PLUS VANILLA 150G&nbsp;&nbsp;memiliki kandungan:&nbsp;</p>\r\n\r\n<ul>\r\n	<li>Minyak Ikan, Omega 3, Omega 6, zat Besi untuk mendukung daya pikir si Kecil</li>\r\n	<li>Tinggi Protein yang penting untuk mendukung pertumbuhan &amp; perkembangan si Kecil</li>\r\n	<li>Kalsium &amp; Vitamin D untuk mendukung pembentukan &amp; mempertahankan kepadatan tulang &amp; gigi si Kecil</li>\r\n	<li>Vitamin C &amp; Zinc untuk mendukung daya tahan tubuh si Kecil</li>\r\n	<li>Serat Pangan Inulin untuk mempertahankan kesehatan saluran cerna si Kecil</li>\r\n	<li>11 Vitamin &amp; 8 mineral lainnya untuk dukung tumbuh kembang optimal si Kecil</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Dukung si Kecil untuk dapat memiliki 5 potensi prestasi anak generasi maju :&nbsp;</p>\r\n\r\n<ul>\r\n	<li>Berpikir Kreatif</li>\r\n	<li>Bantu Tumbuh Kembang</li>\r\n	<li>Supel, Mandiri</li>\r\n	<li>Percaya Diri</li>\r\n</ul>\r\n\r\n<p><br />\r\nMohon memperhatikan petunjuk penyiapan susu SGM Eksplor 1 Plus yang tertera pada kemasan.&nbsp;</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Susu Pertumbuhan untuk Anak Usia 1-3 Tahun.&nbsp;&nbsp;</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<ul>\r\n	<li>Minyak Ikan, Omega 3, Omega 6, zat Besi untuk mendukung daya pikir si Kecil</li>\r\n	<li>Tinggi Protein yang penting untuk mendukung pertumbuhan &amp; perkembangan si Kecil</li>\r\n	<li>Kalsium &amp; Vitamin D untuk mendukung pembentukan &amp; mempertahankan kepadatan tulang &amp; gigi si Kecil</li>\r\n	<li>Vitamin C &amp; Zinc untuk mendukung daya tahan tubuh si Kecil</li>\r\n	<li>Serat Pangan Inulin untuk mempertahankan kesehatan saluran cerna si Kecil</li>\r\n	<li>11 Vitamin &amp; 8 mineral lainnya untuk dukung tumbuh kembang optimal si Kecil&nbsp;</li>\r\n</ul>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Berikan SGM Eksplor 1 Plus minimal tiga kali sehari untuk bantu lengkapi nutrisi si Kecil.&nbsp;</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Mohon memperhatikan petunjuk penyiapan susu SGM Eksplor 1 Plus yang tertera pada kemasan.&nbsp;</p>\r\n', '21062021105921_produk_apotek_online_k24klik_2021052008305123085_Hero-Image-Thumbnail-SGM-Eksplor-Aktif-1--Vanila-150g.png'),
(22, 16, 'SGM eksplor 1 plus madu150g', 15000, 150, 2, 3, '<p>SGM EKSPLOR 1 PLUS MADU 150G&nbsp;merupakan susu pertumbuhan untuk anak usia 1 - 3 tahun&nbsp;untuk melengkapi nutrisi penting yang dibutuhkan,&nbsp;agar si kecil dapat menjadi anak generasi maju yang supel, kreatif dan mandiri.&nbsp;</p>\r\n\r\n<p>SGM EKSPLOR 1 PLUS MADU 150G&nbsp;memiliki kandungan:&nbsp;</p>\r\n\r\n<ul>\r\n	<li>Minyak Ikan, Omega 3, Omega 6, zat Besi untuk mendukung daya pikir si Kecil</li>\r\n	<li>Tinggi Protein yang penting untuk mendukung pertumbuhan &amp; perkembangan si Kecil</li>\r\n	<li>Kalsium &amp; Vitamin D untuk mendukung pembentukan &amp; mempertahankan kepadatan tulang &amp; gigi si Kecil</li>\r\n	<li>Vitamin C &amp; Zinc untuk mendukung daya tahan tubuh si Kecil</li>\r\n	<li>Serat Pangan Inulin untuk mempertahankan kesehatan saluran cerna si Kecil</li>\r\n	<li>11 Vitamin &amp; 8 mineral lainnya untuk dukung tumbuh kembang optimal si Kecil&nbsp;</li>\r\n</ul>\r\n\r\n<p>Dukung si Kecil untuk dapat memiliki 5 potensi prestasi anak generasi maju :&nbsp;</p>\r\n\r\n<ul>\r\n	<li>Berpikir Kreatif</li>\r\n	<li>Bantu Tumbuh Kembang</li>\r\n	<li>Supel</li>\r\n	<li>Mandiri</li>\r\n	<li>Percaya Diri&nbsp;</li>\r\n</ul>\r\n\r\n<p>Mohon memperhatikan petunjuk penyiapan susu SGM Eksplor 1 Plus yang tertera pada kemasan.&nbsp;&nbsp;</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Susu Pertumbuhan untuk Anak Usia 1-3 Tahun. &nbsp;</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Produk Nutrisi Bayi</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<ul>\r\n	<li>Minyak Ikan, Omega 3, Omega 6, zat Besi untuk mendukung daya pikir si Kecil</li>\r\n	<li>Tinggi Protein yang penting untuk mendukung pertumbuhan &amp; perkembangan si Kecil</li>\r\n	<li>Kalsium &amp; Vitamin D untuk mendukung pembentukan &amp; mempertahankan kepadatan tulang &amp; gigi si Kecil</li>\r\n	<li>Vitamin C &amp; Zinc untuk mendukung daya tahan tubuh si Kecil</li>\r\n	<li>Serat Pangan Inulin untuk mempertahankan kesehatan saluran cerna si Kecil</li>\r\n	<li>11 Vitamin &amp; 8 mineral lainnya untuk dukung tumbuh kembang optimal si Kecil&nbsp;</li>\r\n</ul>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Berikan SGM Eksplor 1 Plus minimal tiga kali sehari untuk bantu lengkapi nutrisi si Kecil.&nbsp;</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Mohon memperhatikan petunjuk penyiapan susu SGM Eksplor 1 Plus yang tertera pada kemasan.&nbsp;&nbsp;</p>\r\n', '21062021110143_produk_apotek_online_k24klik_2021052002181423085_Hero-Image-Thumbnail-SGM-Eksplor-Aktif-1--Madu-150g--1-.png'),
(23, 14, 'Lactogen 2 preboitik  180G', 33000, 180, 2, 3, '<p>LACTOGEN 2 merupakan susu formula lanjutan yang diformulasi khusus bagi bayi usia 6-12 bulan untuk membantu tahap awal pertumbuhan anak.</p>\r\n\r\n<p>Indikasi Umum</p>\r\n\r\n<p>Susu Formula Bayi Usia 6 - 12 Bulan.</p>\r\n\r\n<p>Komposisi</p>\r\n\r\n<p>Padatan susu (susu bubuk skim, laktosa, bubuk whey), campuran minyak nabati (mengandung antioksidan tokoferol dan askorbil palmitat), maltodekstrin, 8 mineral dan premiks mineral, minyak LC-PUFA (mengandung minyak ikan (DHA), ARA, mengandung antioksidan tokoferol dan askorbil palmitat), pengemulsi lesitin kedelai, premiks vitamin, Lactobacillus reuteri DSM 17938</p>\r\n\r\n<p>Dosis</p>\r\n\r\n<p>Ikuti petunjuk penggunaan yang terdapat di kemasan.</p>\r\n\r\n<p>Aturan Pakai</p>\r\n\r\n<p>Cuci tangan Anda dengan sabun sebelum membersihkan dan mensterilkan peralatan minum bayi. 2. Cuci peralatan minum bayi dengan air yang mengalir sampai bersih. 3. Rebus peralatan minum bayi dalam air mendidih selama 5-10 menit. Biarkan dalam panci tertutup sampai saat akan dipakai. Bila peralatan minum bayi tidak langsung digunakan, harus disimpan di tempat yang bersih dan tertutup. 4. Cuci tangan dengan sabun dan air mengalir, kemudian keringkan sebelum mengambil peralatan minum bayi. 5. Rebus air minum sampai mendidih selama 10 menit, diamkan di dalam panci tertutup selama 10-15 menit sampai suhunya turun menjadi tidak kurang dari 70&deg;C. 6. Tuangkan air tersebut ke dalam peralatan minum bayi sesuai jumlah yang tertera pada &quot;Petunjuk Penggunaan&quot;. 7. Gunakan sendok takar yang tersedia di dalam kaleng. 8. Masukan bubuk Formula Bayi ke dalam peralatan minum bayi dengan jumlah takaran sesuai &quot;Petunjuk Penggunaan&quot;. 9. Kocok sampai bubuk Formula Bayi larut seluruhnya. 10. Dinginkan segera dengan merendam bagian bawah peralatan minum bayi di dalam air bersih dingin, sampai suhunya sesuai untuk diminum (Dicoba dengan meneteskan Formula Bayi pada pergelangan tangan, akan terasa agak hangat). 11. Sisa Formula Bayi yang sudah dilarutkan dibuang setelah 2 jam. 12. Tutup kaleng dengan rapat setelah digunakan dan simpan di tempat sejuk dan kering. Harus dihabiskan dalam waktu 3 minggu setelah dibuka.</p>\r\n\r\n<p>Perhatian</p>\r\n\r\n<p>Setiap penyajian hanya untuk sekali pemberian. Berikan sesegera mungkin dan ikuti petunjuk dengan tepat. Apabila tidak habis, buang sisa formula bayi yang ada dalam botol.</p>\r\n', '21062021110642_produk_apotek_online_k24klik_20201001014354359225_lactogen-2-180-g.jpg'),
(24, 18, 'ANTIMO STR 10S', 5000, 50, 5, 7, '<p>Antimo merupakan obat yang digunakan untuk mengatasi rasa mual dan muntah akibat mabuk perjalanan (motion sickness) maupun kondisi vertigo. Antimo mengandung zat aktif Dimenhidrinat yaitu obat golongan antihistamin yang efektif untuk mual dan muntah yang disebabkan oleh banyak kondisi. Dimenhidrinat dibantu dengan Vitamin B6 akan bekerja secara efektif pada sistem saraf pusat dengan menghambat zat histamin dan mencegah adanya stimulasi di saraf otak dan telinga dalam yang bisa menyebabkan mual, muntah, dan pusing.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>mabuk, muntah dalam perjalanan yang di derita jika mempergunakan kendaraan bermotor kapal, kereta api atau pesawat udara</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Obat Antivertigo</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>dimenhidrinat 50mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>&gt; 12 tahun: 1 tablet sehari (maksimal 8 tablet), anak 8-12 tahun: 1/2 tablet sehari (maksimal 3 tablet)</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>30 menit sebelum bepergian, jika perlu dapat diulang tiap 4 jam</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>Simpan ditempat sejuk dan kering, terlindung dari cahaya matahari</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>gangguan hati, hipokalemia, hipersensitif terhadap antihistamin, retensi urin dan glaukoma</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>mengantuk, lesu, pusing, dan gangguan koordinasi terutama pada anak-anak, sakit kepala, gangguan psikomotor, mulut kering, pandangan kabur, retensi urin, susah buang air besar, peningkatan reflux lambung, mual, muntah, diare dan nyeri epigastrik, cardiac...</p>\r\n', '21062021111724_produk_Antimo.jpg'),
(25, 18, 'ANTIMO ANAK SYR RASA JERUK 5ML', 15000, 12, 5, 6, '<p>Antimo sirup merupakan anti mual atau muntah yang dikemas dalam bentuk sachet, dengan rasa strawberi yang disukai anak-anak dan praktis dibawa kemana-mana.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Beli Antimo Anak Syr Rasa Jeruk 5ML di apotek online K24klik dan dapatkan manfaatnya</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Mabuk, muntah dalam perjalanan yang diderita jika mempergunakan kendaraan bermotor, kapal, kereta api atau pesawat udara</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antiemetik</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Dimenhidrinat 12mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Hiperemesis : Anak 2-6 tahun : 1-2 sachet setiap 6-8 jam jika perlu, tidak lebih dari sehari 150 mg.</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Diminum &frac12; jam sebelum berpergian dan lebih baik setelah makan</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Penderita gangguan hati, hipokalemia, hipersensitif terhadap antihistamin, retensi urin, glaukoma</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>Depresi susunan saraf pusat seperti mengantuk, lesu pusing dan gangguan koordinasi (terutama pada anak-anak), sakit kepala, gangguan psikomotor, efek antimuskarinik seperti mulut kering, pandangan kabur, retensi urin, konstipasi dan peningkatan refluks lambung, gangguan saluran cerna seperti mual, muntah, diare dan nyeri epigastrik, aritmia jantung atau palpitasi</p>\r\n', '21062021112147_produk_apotek_online_k24klik_201608201226551922_776-Antimo-anak.jpg'),
(26, 18, 'ANTIMO ANAK SYR STRAWBERY 5ML', 15000, 12, 5, 6, '<p>Antimo sirup merupakan anti mual atau muntah yang dikemas dalam bentuk sachet, dengan rasa strawberi yang disukai anak-anak dan praktis dibawa kemana-mana.</p>\r\n\r\n<p>Beli Antimo Anak Syr Strawbery 5ML di apotek online K24klik dan dapatkan manfaatnya.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Mabuk, muntah dalam perjalanan yang diderita jika mempergunakan kendaraan bermotor, kapal, kereta api atau pesawat udara</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antiemetik</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Dimenhidrinat 12,5mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Hiperemesis : Anak 2-6 tahun : 1-2 sachet setiap 6-8 jam jika perlu, tidak lebih dari sehari 150 mg.</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Diminum &frac12; jam sebelum berpergian dan lebih baik setelah makan</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Penderita gangguan hati, hipokalemia, hipersensitif terhadap antihistamin, retensi urin, glaukoma</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>Depresi susunan saraf pusat seperti mengantuk, lesu pusing dan gangguan koordinasi (terutama pada anak-anak), sakit kepala, gangguan psikomotor, efek antimuskarinik seperti mulut kering, pandangan kabur, retensi urin, konstipasi dan peningkatan refluks lambung, gangguan saluran cerna seperti mual, muntah, diare dan nyeri epigastrik, aritmia jantung atau palpitasi</p>\r\n', '21062021112421_produk_apotek_online_k24klik_2016022503292813_antimo-anak.jpg'),
(27, 19, 'BODREX TAB', 5000, 650, 5, 7, '<p>Paracetamol sendiri berfungsi sebagai anti nyeri dan penurun panas atau demam,paduan dengan Caffeine meningkatkan efek analgetik sehingga mampu meredakan nyeri ringan-sedang dengan cepat&nbsp;</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>meringankan sakit kepala, migren, demam, pusing</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Analgesik (Non Opiat) dan Antipiretik</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Tiap tablet mengandung: Paracetamol 600 mg dan Caffeine 50 mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>3-4 kali sehari 1-2 kaplet. Maksimal : 8 kaplet/24 jam. Tidak untuk anak</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Sesudah makan</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Penderita dengan gangguan fungsi hati,Penderita yang hipersensitif terhadap salah satu atau seluruh komponen obat</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>Dosis besar dapat menyebabkan kerusakan hati</p>\r\n', '21062021121234_produk_BODREX-20-TAB.jpg'),
(28, 19, 'BODREX FLU&BATUK BERDAHAK PE CAPL 4S', 2000, 568, 5, 7, '<p>Bodrex Flu &amp; Batuk Berdahak PE merupakan rangkaian dari bodrex flu &amp; batuk PE khusus untuk batuk berdahak pertama di Indonesia dengan PE (Phenylephrine) yang berfungsi sebagai dekongestan untuk meredakan hidung tersumbat. bodrex Flu &amp; Batuk PE berkhasiat atasi flu &amp; batuk tanpa ngantuk secara cepat dan aman.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Meredakan gejala flu seperti demam, sakit kepala, hidung tersumbat dan bersin-bersin yang disertai batuk berdahak.</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Analgesik (Non Opiat) dan Antipiretik</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Tiap kaplet lapis dua mengandung : Paracetamol 500 mg, Phenylephrine HCL 10 mg, Glyceryl Guaiacolate 50 mg, Bromhexine HCL 8 mg.</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Dewasa : 1 kaplet 3 kali sehari.</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Hati-hati penggunaan pada penderita dengan gangguan fungsi hati dan ginjal, glaukoma, hipertrofi prostat, hipertiroid dan retensi urin. Tidak dianjurkan penggunaan pada anak usia dibawah 2 tahun, wanita hamil dan menyusui, kecuali atas petunjuk dokter.</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>Gangguan pencernaan, insomnia, gelisah, aksitasi, tremor, takikardia, mulit kering, palpitasi, dan retensi urin. Penggunaan dosis besar dan jangka panjang menyebabkan kerusakan hati.</p>\r\n', '21062021121622_produk_apotek_online_k24klik_201902140248564677_bodrex-BB-PE.jpeg'),
(29, 19, 'BODREX FLU&BATUK KERING PE CAPL 4S', 2000, 582, 5, 7, '<p>Bodrex Flu dan Batuk biru merupakan obat yang digunakan untuk mengatasi flu dan batuk tidak berdahak.</p>\r\n\r\n<p>Beli Bodrek Flu&amp;Batuk Kering STR 4&#39;S di apotek online K24klik dan dapatkan manfaatnya.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Meredakan gejala-gejala flu yang disertai batuk kering</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Obat Batuk dan Pilek</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Paracetamol 500 mg, pseudoephedrine HCl 30 mg, dextromethorphan HBr 12 mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Dewasa : 3 kali sehari 1 kaplet. Anak : 3 kali sehari &frac12; kaplet</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Berikan bersama makanan</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Gangguan fungsi hati dan ginjal, glaukoma, hipertrofi prostat, hipertiroid, penyakit jantung, DM. Dapat meningkatkan risiko gangguan fungsi hati pada pasien yang mengkonsumsi alkohol. Pasien dalam kondisi lemah fisik dan hipoksia. Hipertensi. Anak</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>Gangguan psikomotorik, takikardi, aritmia, palpitasi, retensi urin; mengantuk. Kerusakan hati (karena dosis besar dan penggunaan jangka lama)</p>\r\n', '21062021121845_produk_apotek_online_k24klik_20191214101504303669_BODREX-FLU-BATUK--KERING-STR-4S-2.jpg'),
(30, 19, 'BODREX MIGRA TAB 4S', 2000, 580, 5, 7, '<p>Membantu meringankan rasa sakit kepala pada migrain. Beli Bodrex Migra di K24klik dan dapatkan manfaatnya</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Meringankan rasa sakit kepala pada migrain.</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Analgesik (Non Opiat) dan Antipiretik</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Paracetamol 350 mg, propyphenazone 150 mg, caffeine 50 mg.</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Dewasa : 1 kaplet 3 kali sehari atau menurut petunjuk dokter</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Sebaiknya diberikan bersama makanan : Berikan sesudah makan.</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>Simpan di tempat sejuk dan kering serta terhindar dari sinar matahari langsung</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Hati-hati penggunaan pada penderita porfiria. Hati-hati penggunaan obat ini pada penderita penyakit ginjal. Penggunaan obat ini pada penderita yang mengkonsumsi alkohol, dapat meningkatkan risiko kerusakan fungsi hati.Bila setelah 5 hari rasa nyeri tidak b</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>&ndash; Penggunaan jangka panjang dan dosis besar dapat menyebabkan kerusakan fungsi ginjal. &ndash; Reaksi hipersensitif.</p>\r\n', '21062021122102_produk_apotek_online_k24klik_201810170246314677_bodrex-migra.jpeg'),
(31, 20, 'KONIDIN TABLET 4S', 3000, 125, 5, 7, '<p>Tablet konidin sebagai obat batuk diproduksi oleh PT Konimex. Dalam 1 tablet konidin mengandung guaifenesin, dextromethorphan Hbr, dan CTM. Dextromethorphan HBr termasuk golongan antitusif jadi cocok untuk batuk kering. Guaifenesin merupakan ekspektoran yang dapat membantu melegakan tenggorokan, sehingga batuk akan lebih mudah dilepaskan. Terakhir, CTM sering kita dengar digunakan sebagai antihistamin untuk alerginya</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Untuk mengatasi batuk karena alergi, flu, pilek, atau sisa-sisa bronkitis</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Obat Batuk dan Pilek</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Guaifenesin 100 mg, dextromethorphan HBr 5 mg, chlorpeniramine maleate 2 mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>dewasa dan anak-anak &gt; 12 tahun: 3 x sehari 1-2 tablet; anak-anak 6-12 tahun: 3 x sehari 1/2-1 tablet; anak-anak 3-6 tahun: 3 x sehari 1/4-1/2 tablet;</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Diberikan setelah makan</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>mengantuk, letih, gangguan pencernaan</p>\r\n', '21062021122324_produk_Konidin-4tab.png'),
(32, 24, 'OSKADON TAB STR 4S', 2000, 535, 5, 7, '<p>Oskadon merupakan obat sakit kepala keluarga yang juga dapat mengurangi nyeri otot, nyeri saraf dan nyeri gigi.</p>\r\n\r\n<p>Beli Oskadon tablet di apotek online K24klik sekarang dan dapatkan manfaatnya</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Sakit kepala, migrain, nyeri otot dan nyeri sendi, nyeri saraf, sakit gigi dan demam yang berhubungan dengan flu dan masuk angin</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Analgesik (Non Opiat) dan Antipiretik</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Paracetamol 500 mg, caffein 35 mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Dewasa : 3-4 x sehari 1-2 tablet Anak-anak : 3-4 x sehari 1/2-1 tablet</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Berikan dengan atau tanpa makanan</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Gangguan fungsi ginjal dan hati, hindari penggunaan bersama dengan antikoagulan oral</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>Gangguan saluran pencernaan, takhikardia</p>\r\n', '21062021122536_produk_Oskadon.jpg'),
(33, 23, 'NEOZEP F TAB 4S STRIP', 3000, 525, 5, 7, '<p>Neozep Forte merupakan obat untuk meringankan gejala flu seperti demam, sakit kepala, hidung tersumbat dan bersin-bersin.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Setiap 1 tablet Neozep mengandung:</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>Paracetamol (Acetaminophen) adalah zat aktif yang memiliki aktivitas sebagai penurun demam/antipiretik dan pereda nyeri/analgesik yang bisa diperoleh tanpa resep dokter.</li>\r\n	<li>Dexchlorpheniramine maleate (CTM) adalah zat aktif yang digunakan untuk mengobati&nbsp; gejala alergi seperti rhinitis dan urtikaria. Termasuk dalam golongan antihistamin generasi pertama yang memiliki efek sedatif rendah.</li>\r\n	<li>Salisilamida adalah obat turunan asam salisilat yang berperan sebagai analgesik (penghilang rasa nyeri) ringan. Biasanya dalam penggunaan sering dikombinasikan dengan parasetamol dan kafein.</li>\r\n	<li>Phenylpropalamine adalah zat aktif yang berfungsi sebagai stimulan dan nasal dekongestan (untuk mengatasi pilek dan hidung tersumbat).</li>\r\n</ol>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>meringankan gejala flu seperti demam,sakit kepala, hidung tersumbat dan bersin-bersin</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Obat Batuk dan Pilek</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>fenilpropanolamin hcl 15 mg, ctm 2mg, paracetamol 250mg, salisilamida 150 mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>dewasa : 3-4 kali sehari 1 tablet. anak-6-12 thn : 3-4 kali sehari 1/2 tablet</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>sesudah makan</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>simpan di tempat sejuk dan kering, terhindar dari paparan sinar matahari langsung</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>penderita dengan gangguan jantung dan diabetes melitus , penderita dengan gangguan fungsi hati yang berat</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>mengantuk, gangguan pencernaan , takikardia, aritmia, mulut kering , retensi urin, iritasi lambung, penggunaan dengan dosis besar dan jangka panjang menyebapkan kerusakan hati.</p>\r\n', '21062021122833_produk_NEOZEP-F-TAB-STR-25S-2.jpg'),
(34, 22, 'NEO ULTRASILINE CR 5G', 10000, 5, 2, 2, '<p>NEO ULTRASILINE CR 5G merupakan salep kulit yang dapat digunakan untuk pengobatan topikal dari candidiasis, Pityriasis versicolor, Tinea pedis, Tinea cruris dan tinea corporis. Tersedia dalam bentuk tube yang didistribusikan oleh Henson Farma.<br />\r\nBeli NEO ULTRASILINE CR 5G di K24Klik.com dan dapatkan manfaatnya.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Untuk pengobatan topikal dari candidiasis, Pityriasis versicolor, Tinea pedis, Tinea cruris dan tinea corporis.</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antijamur dan Antiparasit Topikal</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Clotrimazole 1%</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>2-3 kali sehari</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Topikal, cuci bersih pada bagian kulit sebelum dioleskan krim.</p>\r\n', '21062021123222_produk_NEO-ULTRASILINE-CR-5G-2.jpg'),
(35, 26, 'SANGOBION CAP 10S', 16000, 350, 5, 7, '<p>SANGOBION CAP 10&#39;S adalah vitamin &amp; zat besi penambah darah untuk mengatasi anemia (kurang darah) karena kekurangan zat besi dan mineral. Produk ini mengandung zat besi, vitamin dan mineral yang penting dalam pembentukan sel darah merah, terutama Hemoglobin (Hb) yang berperan mengangkut oksigen ke seluruh tubuh sehingga dapat membantu pembentukan sel darah merah untuk mengatasi anemia (kurang darah). Sangobion juga mengandung Vit.C yang dapat membantu meningkatkan penyerapan zat besi dan merupakan suplemen zat besi pertama yang mendapat sertifikasi halal dari MUI<br />\r\nBeli SANGOBION CAP 10&#39;S di K24Klik.com dan dapatkan manfaatnya.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>anemia karena kekurangan zat besi dan mineral lain yang membantu pembentukan darah</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Vitamin dan Mineral (untuk Masa Hamil dan Nifas)/Antianemia</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>1 kapsul mengandung Ferrous Gluconate 250 mg Manganese Sulfate 0, 2 mg Copper Sulfate 0, 2 mg Vitamin C 50, 0 mg Asam Folat / Folic Acid 1,0 mg Vitamin B 12 7, 5 mcg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>1 kapsul sehari pada waktu atau sesudah makan. Dapat dikonsumsi mulai dari 3 hari sebelum dan selama periode menstruasi</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Dapat dikonsumsi mulai dari 3 hari sebelum dan selama periode menstruasi</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>simpan di tempat sejuk dan kering, terhindar dari paparan sinar matahari langsung</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>akumulasi zat besi, gangguan penggunaan zat besi</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>nyeri lambung, muntah, konstipasi, diare, kolik</p>\r\n', '21062021123929_produk_SANGOBION.jpg'),
(36, 25, 'PROMAG TABLET', 8000, 400, 5, 7, '<p>Promag merupakan obat kombinasi antara antasida dengan simetikon yang digunakan untuk terapi dyspepsia (maag) dengan mengurangi gejala maag seperti kembung, mual, dan bersendawa. Promag mengandung antasida Magnesium (Mg(OH)) dan Hydrotalcite dengan Simetikon yang dapat menetralkan asam lambung dan mengurangi gas yang berlebihan di saluran pencernaan (antiflatulen).</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>untuk meringankan gejala yang berhubungan dengan kelebihan asam lambung, gastritis, tukak lambung, tukak usus 12 jari, dengan gejala seperti: mual, nyeri lambung, nyeri ulu hati, kembung dan perasaan penuh pada lambung</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antasid, Obat Antirefluks &amp; Antiulserasi</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>hydrotalcite 200mg, magnesium hydroxide 150 mg, simethicone 50mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>dewasa : 3-4 x sehari 1-2 tablet. Anak-anak 6-12 th : 3-4 x sehari 1/2-1 tablet</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>dianjurkan untuk meminum obat ini segera pada saat timbul gejala dan dilanjutkan 1-2 jam sebelum makan atau sesudah makan dan sebelum tidur</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>Simpan di tempat sejuk dan kering, terhindar dari sinar matahari langsung</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>gangguan fungsi ginjal, tidak dianjurkan untuk anak dibawah 6 tahun, tidak dianjurkan untuk digunakan terus menerus selama 2 minggu, kecuali atas &nbsp;petunjuk dokter</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>sembelit, diare, mual,muntah.</p>\r\n', '21062021124405_produk_Promag_Tablet.jpg'),
(37, 25, 'PROMAG CAIR 7ML', 15000, 7, 1, 6, '<p>Promag cair untuk mengurangi gejala yang berhubungan dengan kelebihan asam lambung, gastritis, tukak lambung, dan tukak usus 12 jari.<br />\r\n<br />\r\n<br />\r\nBeli Promag Cair 7ML Sach 6S di K24klik dan dapatkan manfaatnya.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Untuk mengurangi gejala yang berhubungan dengan kelebihan asam lambung, gastritis, tukak lambung, dan tukak usus 12 jari dengan gejala mual, kembung, nyeri lambung, nyeri ulu hati, dan rasa penuh pada lambung</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antasid, Obat Antirefluks &amp; Antiulserasi</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Hydrotalcite 200mg, Mg(OH)2 150mg, Simethicone 50mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Dewasa : 3-4 x sehari 1-2 sachet, anak 6-12 tahun : 1/2-1 sachet</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>satu jam sebelum atau sesudah makan, dan sebelum tidur malam</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>simpan di tempat yang sejuk dan kering, serta terlindung dari panas dan sinar matahari langsung</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Aman dikonsumsi untuk ibu hamil dan menyusui</p>\r\n', '21062021125025_produk_apotek_online_k24klik_20201127030453359225_PROMAG-SUS.jpg'),
(38, 25, 'PROMAG GAZERO', 15000, 10, 1, 6, '<p>Promag Gazero memiliki kandungan delapan (8) macam herbal yang berkhasiat dalam membantu meredakan perut kembung, mual, begah, dan masuk angin. Diformulasikan khusus dari ekstrak herbal alami jahe merah, adas, kunyit, peppermint, ananas, madu, dan royal jelly.</p>\r\n\r\n<p>Royal Jelly adalah sekresi susu yang dihasilkan oleh kelenjar lebah madu pekerja yang mengandung protein, beberapa jenis vitamin, gula, garam dan asam amino yang dipercaya bermanfaat bagi kesehatan manusia.&nbsp;</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>mengatasi perut kembung dan begah.</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antasid, Obat Antirefluks &amp; Antiulserasi</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Jahe merah 50mg, adas 10mg, peppermint 12.5mg, akar manis 300mg, kunyit 50mg, ananas 50mg, royal jelly 10mg, honey 1g</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>3 x sehari 1 sachet</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>bisa diminum langsung atau dicampur dengan air hangat</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>simpan di tempat yang kering dan terlindung dari cahaya</p>\r\n', '21062021125258_produk_apotek_online_k24klik_20200901023331359225_PROMAG-GAZERO.jpg'),
(39, 39, 'AMLODIPINE DEXA 10MG', 3000, 10, 5, 7, '<p>AMLODIPINE DEXA 10MG TAB 100S termasuk obat golongan antagonis kalsium yang bekerja dengan menghambat arus masuk ion kalsium di dalam membran sel aktif. Amlodipine mampu melemaskan dinding pembuluh darah sehingga memperlancar aliran darah menuju jantung dan mengurangi tekanan darah. Amlodipine Dexa 10 mg digunakan untuk mengatasi hipertensi atau tekanan darah tinggi, terapi lini pertama untuk infark miokard serta terapi kombinasi atau monoterapi untuk angina. Obat ini dapat dikonsumsi sebelum atau sesudah makan dengan air putih dengan memastikan ada jarak yang cukup antara satu dosis dengan dosis berikutnya.Tidak disarankan penggunaan pada pasien dengan riwayat hipersensitif terhadap dihidropiridin. Interaksi dapat terjadi apabila digunakan bersamaan dengan obat-obatan seperti: *Amiodarone *Simvastatin *Clarithromycin *Clopidogrel *Ciclosporin *Dantrolene *Digoxin Beli AMLODIPINE DEXA 10MG TAB 100S di K24Klik dan dapatkan manfaatnya.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Hipertensi, infark miokard, angina</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antagonis Kalsium</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Amlodipine 10 mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Dapat diberikan sebelum atau sesudah makan.</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>*Hipertensi &amp; angina: Awal 5 mg/hari dapat ditingkatkan menjadi 10 mg/hari. *Angina stabil kronik atau angina vasospatik 5-10 mg.</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>Simpan di tempat sejuk dan kering, serta terhindar dari sinar matahari langsung.</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>*Gangguan hati dan ginjal *Gagal jantung kongestif *Hamil dan laktasi *Anak *Lanjut usia</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>Sakit kepala, edema, lelah, somnolen, mual, nyeri perut, rasa hangat dan kemerahan pada wajah, palpitasi dan pusing.</p>\r\n', '21062021125549_produk_amlodipine_10_mg_tab_hexp_full02.jpg'),
(40, 28, 'BIOPLACENTON GEL 15G', 30000, 15, 2, 2, '<p>BIOPLACENTON GEL 15G merupakan obat yang memiliki kandungan Placenta Extract dan Neomycin Sulfate. Obat ini digunakan untuk mengobati luka bakar, luka dengan infeksi, serta luka kronik dan jenis luka yang lain.&nbsp;</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>penyembuhan luka bakar, luka terinfeksi, scald, dan ulkus kulit</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antibiotik Topikal</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>ekstrak placenta dari sapi 10%, neomycin sulfate 0.5%, jelly base</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>3-5 kali sehari, dioleskan</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>dioleskan</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>hipersensitif terhadap komponen</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>reaksi hipersensitif, ototoksisitas jika bersamaan jika diberikan bersamaan obat ototoksik lainnya</p>\r\n', '21062021130334_produk_BIOPLACENTON-GEL-15G-2.jpg'),
(41, 39, 'DEXAMETHASONE KF 0.5MG', 3000, 5, 5, 7, '<p>Dexamethason produksi PT. Kimia Farma telah terdaftar pada BPOM. Pada setiap tabletnya mengandung 0,5mg dexamethasone. Dexamethasone merupakan glukokortikoid sintetis yang bekerja mengurangi peradangan dengan menghambat migrasi leukosit dan pembalikan permeabilitas kapiler yang meningkat. Dexamethason efektif digunakan untuk terapi terhadap inflamasi, alergi dan penyakit lain yang responsif terhadap glukokortikoid.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>inflamasi, alergi dan penyakit lain yang responsif terhadap glukokortikoid</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Hormon Kortikosteroid</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>dexamethasone 0,5mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>0,5-10mg per hari</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>diminum saat makan</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>simpan di tempat sejuk dan kering, terhindar dari paparan sinar matahari langsung</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>hipotiroid, sirosis hati, terapi jangka lama</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>lemah otot, osteoporosis, tukak peptik, gangguan penyembuhan luka, keringat berlebih, sakit kepala, gangguan siklus haid, hambat pertumbuhan pada anak, penurunan toleransi terhadap karbohidrat</p>\r\n', '21062021132012_produk_DEXAMETHASONE--2-.jpg'),
(42, 39, 'GENTAMICYN SULFAT 5G', 5000, 5, 2, 2, '<p>Salep Garamycin mengandung antibiotik gentamicin yang merupakan antibiotik golongan aminoglikosida, yang mempunyai efek bakterisidal terutama terhadap basilus aerobik gram negatif yang sensitif, dan bakteri gram positif yang sensitif.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Untuk pengobatan topikal infeksi primer dan sekunder pada kulit yang disebabkan oleh bakteri yang peka terhadap gentamicin. Tidak digunakan untuk antibiotik pencegahan/profilaksis karena bakteri penyebab tidak diketahui</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antibiotik Topikal</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Setiap 1 gram Garamycin mengandung gentamicin sulfate yang ekuivalen dengan 1 mg (0,1%) Gentamicin.</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Krim/Salep Garamisin dioleskan tipis pada daerah yang sakit sebanyak 3 &ndash; 4 kali sehari sampai tercapai kesembuhan. Daerah yang sakit boleh ditutupi dengan perban (gauze dressing).</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Tidak boleh digunakan untuk pengobatan mata</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>Penggunaan topikal antibiotik gentamisin dapat menyebabkan iritasi yang bersifat sementara, biasanya ditandai dengan kulit kemerahan dan gatal. Kemungkinan terjadinya fotosensitisasi pernah dilaporkan pada beberapa pasien. Penggunaan antibiotik gentamisin topikal dalam jangka panjang dapat menyebabkan jamur atau bakteri yang kebal tumbuh berlebihan.</p>\r\n', '21062021132242_produk_Gentamicin.png'),
(43, 39, 'PIROXICAM IF 20MG ', 3000, 20, 5, 7, '<p>Piroxicam merupakan obat generik yang diproduksi oleh PT Indofarma. Piroxicam termasuk golongan NSAID yang sangat berisiko bila digunakan oleh pasien yang sudah memiliki masalah jantung sebelumnya. Piroxicam digunakan untuk mengobati rheumatoid arthritis dan osteoarthritis. Cara kerja Piroxicam yaitu dengan mengurangi hormon yang menyebabkan peradangan dan rasa nyeri di tubuh</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Osteoarthritis, spondilitis ankilosa, gangguan muskuloskeletal akut, gout akut,</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Obat Anti Inflamasi Non Steroid (OAINS)</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Piroxicam 20 mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>reumatoid arthritis, osteoarthritis, spondilitis ankilosa : 1 x sehari 20 mg ; Gangguan muskoloskeletal akut : 40 mg/hari dalam dosis tunggal atau terbagi selama 2 hari, kemudian 1 x sehari 20 mg selama 7-14 hari ; Gout akut : dosis awal 40 mg /hari dalam dosis tunggal, kemudian 40 mg dosis tunggal atau terbagi selama 4-6 hari. Tidak untuk terapi gout jangka panjang</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Diberikan sesudah makan</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Riwayat ulkus gaster, gangguan jantung, hipertensi, kerusakan ginjal atau hati, retensi urine, usia lanjut</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>Gangguan pencernaan, sakit kepala, pusing, penglihatan kabur, iritasi</p>\r\n', '21062021132433_produk_piroxicam_obat_resep_dokter_-100_tablet-_20_mg-box-_full01_qu10vtiu.jpg'),
(44, 40, 'RANITIDINE HEXPHARM 150MG', 4000, 150, 5, 7, '<p>Ranitidine Hexpharm merupakan obat antasida yang diproduksi oleh PT. Hexpharm dan telah terdaftar pada BPOM. Ranitidine Hexpharm mengandung 150mg ranitidine pada setiap tabletnya. Ranitidine Hexpharm dapat digunakan untuk mengobati tukak duodenum aktif jangka pendek, tukak lambung aktif dan menurangi gejala refluks esofagitis. Ranitidine Hexpharm juga dapat digunakan untuk terapi pemeliharaan setelah penyembuhan tukak duodenum dan lambung.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>pengobatan jangka pendek tukak dudenum aktif, tukak lambung aktif, mengurangi gejala refluks esofagitis, terapi pemeilharan setelah penyembuhan tukak duodenum dan lambung.</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antasid, Obat Antirefluks &amp; Antiulserasi</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>ranitidine 150mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>tukak duodenum : 2 kali sehari 150mg (pagi dan malam) selama 4-8minggu. tukak lambung aktif : 2 kali sehari 150mg (pagi dan malam) selama 2 minggu. terapi pemeliharaan tukak duodenum dan lambung : 1 kali sehari 150mg sebelum tidur. refluks gastro esofagitis : 2 kali sehari 150mg. esofagitis erosif : 4 kali sehari 150mg. terapi pemeliharaan esofagitis erosif : 2 kali sehari 150mg.</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>diminum sebelum atau setelah makan</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>pasien dengan riwayat profiria akut. ibu hamil dan menyusui, anak, usia lanjut. gangguan fungsi hati dan ginjal.</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>sakit kepala, malaise (merasa lemas dan kurang fit), pusing, mengantuk, insomnia, vertigo, agitasi (resah dan gelisah), depresi, halusinasi, gangguan gastrointestinal.</p>\r\n', '21062021132735_produk_apotek_online_k24klik_20200812025104359225_RANITIDINE-HCL-150-MG.jpg'),
(45, 39, 'RANITIDINE 150MG', 3000, 150, 5, 7, '<p>Ranitidine yang diproduksi oleh Erela merupakan penghambat histamin, yang bekerja dengan memblokir histamin yang merangsang pelepasan asam lambung. Oleh karena itu, Ranitidine dapat digunakan untuk mengobati ulkus duodenum aktif, ulkus gaster benigna aktif, refluks esofagitis, pencegahan relaps ulkus peptikum, hipersekresi patologis seperti sindroma zollinger-ellison. Ranitidine diproduksi dalam bentuk tablet selaput untuk menutupi rasa pahit dari zat aktif yang terdapat di dalamnya.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>ulkus duodenum aktif, ulkus gaster benigna aktif, refluks esofagitis, pencegahan relaps ulkus peptikum, hipersekresi patologis</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antasid, Obat Antirefluks &amp; Antiulserasi</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Ranitidine HCl</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>tukak duodenum aktif dan ulkus gaster benigna: 2 kali sehari 150 mg selama 4-8 mg, pemeliharaan 1 kali sehari 150 mg sebelum tidur malam. Refluks esofagitis: 2 kali sehari 150 mg selama kurang dari sama dengan 8 minggu. Pencegahan relaps ulkus peptikum 150 mg menjelang tidur untuk 12 bulan. Kondisi hipersekresi patologis: awal 3 kali sehari 150 mg dan dapat ditingkatkan menjadi kurang dari sama dengan 6 gram per hari dalam dosis terbagi. Pasien dengan gangguan ginjal dengan bersihan kreatinin &lt; 50ml/menit 150 mg/24jam.</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>diminum sebelum atau sesudah makan dan sebelum tidur malam</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>simpan di tempat sejuk dan kering, terhindar dari paparan sinar matahari langsung</p>\r\n', '21062021132913_produk_Ranitidine.jpg');
INSERT INTO `produk` (`id_produk`, `id_merk`, `nama`, `harga`, `ukuran`, `satuan_ukuran`, `satuan_barang`, `deskripsi`, `gambar`) VALUES
(46, 35, 'SCABIMITE CR 10G', 65000, 10, 2, 2, '<p>Scabimite merupakan obat berbentuk krim yang mengandung 5% permethrin.Scabimite diproduksi oleh PT. Galenium Pharmasia Lab-Indonesia dan telah terdaftar pada BPOM. Scabimite dapat digunakan untuk mengobati masalah kulit yaitu skabies (gatal pada kulit yang disebabkan oleh tungau atau kutu kecil).</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>skabies</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Antijamur dan Antiparasit Topikal</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>permethrin 5%</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>oleskan 1 kali sehari</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>oleskan pada bagian yang gatal di malam hari</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>hindari kontak dengan mata. ibu hamil dan menyusui. bayi</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>rasa terbakar dan tersengat yang ringan dan sementara,gatal, eritema, ruam kulit</p>\r\n', '21062021133045_produk_apotek_online_k24klik_201810301024334677_scabimite.jpeg'),
(47, 39, 'SIMVASTATIN KF 10MG', 3000, 10, 5, 7, '<p>Obat Simvastatin banyak diproduksi oleh perusahaan-perusahaan farmasi di Indonesia, salah satunya adalah Kimia Farma dengan potensi 20 mg. Simvastatin termasuk dalam golongan obat inhibitor reductase HMG CoA atau statin. Simvastatin mengurangi kadar kolesterol buruk (LDL) dan trigliserid dalam darah, sekaligus menaikkan kadar HDL (kolesterol baik). Selain itu, Simvastatin juga digunakan untuk menurunkan risiko stroke, serangan jantung, dan komplikasi jantung lainnya pada penderita diabetes, penyakit jantung koroner, atau faktor risiko yang lain. Simvastatin hanya digunakan oleh orang dewasa dan anak-anak paling tidak usia 10 tahun</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Mengurangi kadar kolesterol total dan ldl pada penderita hiperkolesterolemia primer dan sekunder , meningkatkan kadar hdl</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Obat Dislipidemia</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Simvastatin 10 mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>awal : 1 x 10 mg sehari sebagai anti hiperkolesterol ringan 5 mg sehari maksimal 40 mg sehari</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Malam hari sebelum tidur</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>Simpan ditempat sejuk dan kering, terlindung dari cahaya matahari</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>Jangan mengkonsumsi jus grapefruit secara berlebihan. Monitoring kadar lipid tiap 3 bulan (pada pemakaian lama). gangguan hepatik akut, peningkatan sgot/sgpt tanpa penjelasan, hamil dan laktasi</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>nyeri abdomen, konstipasi, dan kembung</p>\r\n', '21062021133305_produk_simvastatin.jpg'),
(48, 40, 'SIMVASTATIN HEXPHARM 10MG', 4000, 10, 5, 7, '<p>SIMVASTATIN HEXPHARM 10MG TAB 100S merupakan obat untuk mengurangi kadar kolesterol buruk (LDL) dan trigliserid dalam darah, sekaligus menaikkan kadar HDL (kolesterol baik) serta digunakan untuk menurunkan risiko kematian karena penyakit jantung koroner, menurunkan risiko infark miokard non fatal, menurunkan risiko pada pasien yang sedang menjalani tindakan revaskularisasi miokardial. Simvastatin termasuk obat golongan inhibitor reductase HMG CoA atau statin yang bekerja dengan cara menghambat enzim pembentuk kolesterol jahat sehingga kadar kolesterol dalam darah berkurang. Simvastatin dapat dikonsumsi sebelum atau sesudah makan pada malam hari, biasanya satu kali setiap hari di waktu malam sebelum tidur atau sesuai yang disarankan oleh dokter. Konsultasikan kepada dokter terlebih dahulu apabila akan digunakan pada pasien dengan kondisi alergi terhadap makanan atau kandungan yang terdapat pada obat ini, pasien dengan penyakit hati aktif atau peningkatan persisten transaminase serum, wanita hamil dan menyusui serta pasien dengan penyakit ginjal dan penyakit tiroid. Interaksi dapat terjadi apabila digunakan bersamaan dengan obat-obatan seperti: *Imunosupresan *Itrakonazol *Gemfibrozil *Niasin *Eritromisin *Kumarin *Antipirin *Propanolol *Digoksin Interaksi simvastatin dan makanan dapat terjadi terutama dengan grapefruit (limau gedang). Buah ini dapat meningkatkan penyerapan obat dalam aliran darah. Beli SIMVASTATIN HEXPHARM 10MG TAB 100S di K24Klik dan dapatkan manfaatnya.</p>\r\n\r\n<h2>Indikasi / Manfaat / Kegunaan :</h2>\r\n\r\n<p>Menurunkan kadar kolestrol total &amp; LDL pada pasien dengan hiperkolesterolemia primer (tipe IIa &amp; IIb).</p>\r\n\r\n<h2>Sub Kategori</h2>\r\n\r\n<p>Obat Dislipidemia</p>\r\n\r\n<h2>Komposisi</h2>\r\n\r\n<p>Simvastatin 10 mg</p>\r\n\r\n<h2>Dosis</h2>\r\n\r\n<p>Dapat diberikan sebelum atau sesudah makan pada malam hari.</p>\r\n\r\n<h2>Penyajian</h2>\r\n\r\n<p>Awal: 5-10 mg 1 kali sehari (malam hari). Maksimal 40 mg/hari sebagai dosis tunggal.</p>\r\n\r\n<h2>Cara Penyimpanan</h2>\r\n\r\n<p>Simpan di tempat sejuk dan kering, serta terhindar dari sinar matahari langsung.</p>\r\n\r\n<h2>Perhatian</h2>\r\n\r\n<p>*Pantau kadar kolesterol secara periodik selama terapi. Lakukan tes fungsi hati sebelum terapi, 6 &amp; 12 bulan setelah terapi pertam dan selanjutnya secara periodik. *Riwayat penyakit hati. *Miopati akut dan berat atau pasien dengan risiko gagal ginjal sekunder akibat rabdomiolisis.</p>\r\n\r\n<h2>Efek Samping</h2>\r\n\r\n<p>Nyeri perut, konstipasi, kembung, astenia, sakit kepala, miopati, rabdomiolisis, tremor, pusing, vertigo.</p>\r\n', '21062021133416_produk_apotek_online_k24klik_20200810110733359225_SIMVASTATIN-10-MG--2.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `produk_jenis`
--

CREATE TABLE `produk_jenis` (
  `id_produk_jenis` int(5) NOT NULL,
  `id_produk` int(4) NOT NULL,
  `id_jenis` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk_jenis`
--

INSERT INTO `produk_jenis` (`id_produk_jenis`, `id_produk`, `id_jenis`) VALUES
(2, 1, 1),
(3, 2, 1),
(5, 3, 3),
(6, 3, 4),
(13, 12, 7),
(15, 13, 2),
(16, 14, 7),
(17, 14, 8),
(18, 15, 8),
(19, 15, 7),
(20, 16, 8),
(21, 16, 7),
(22, 17, 7),
(23, 17, 8),
(24, 18, 8),
(25, 18, 7),
(26, 19, 7),
(27, 19, 8),
(28, 20, 7),
(29, 20, 8),
(30, 21, 7),
(31, 21, 8),
(32, 22, 7),
(33, 22, 8),
(34, 23, 7),
(35, 23, 8),
(36, 24, 2),
(37, 25, 2),
(38, 26, 2),
(39, 27, 8),
(40, 27, 11),
(41, 28, 1),
(42, 28, 6),
(43, 29, 2),
(44, 29, 6),
(45, 30, 2),
(46, 30, 10),
(47, 31, 2),
(48, 31, 6),
(49, 32, 8),
(50, 32, 10),
(51, 33, 11),
(52, 33, 2),
(53, 34, 2),
(54, 34, 4),
(55, 35, 8),
(56, 35, 12),
(57, 36, 8),
(58, 36, 9),
(59, 37, 8),
(60, 37, 9),
(61, 38, 8),
(62, 38, 9),
(63, 38, 14),
(64, 39, 3),
(65, 40, 3),
(66, 40, 4),
(67, 41, 3),
(68, 42, 3),
(69, 42, 4),
(70, 43, 3),
(71, 44, 3),
(72, 45, 3),
(73, 46, 3),
(74, 47, 3),
(75, 48, 3);

-- --------------------------------------------------------

--
-- Table structure for table `produk_merk`
--

CREATE TABLE `produk_merk` (
  `id_merk` int(4) NOT NULL,
  `merk` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk_merk`
--

INSERT INTO `produk_merk` (`id_merk`, `merk`) VALUES
(1, 'Betadine'),
(2, 'Salonpas'),
(3, 'Bisolvon'),
(7, 'ZEE'),
(8, 'Anlene'),
(9, 'Decolgen'),
(10, 'Bebelac'),
(11, 'Dancow'),
(12, 'Diabetasol'),
(13, 'Entrasol'),
(14, 'lactogen'),
(15, 'Prenagen'),
(16, 'SGM'),
(17, 'Vidoran'),
(18, 'Antimo'),
(19, 'Bodrex'),
(20, 'Konidin'),
(21, 'Neo Entrostop'),
(22, 'Neo Ultrasilin'),
(23, 'Neozep'),
(24, 'Oskadon'),
(25, 'Promag'),
(26, 'Sangobion'),
(27, 'Amlodipine'),
(28, 'Bioplacenton'),
(29, 'Dexamethasone'),
(30, 'Gentamicin'),
(31, 'Omeprazole'),
(32, 'Omestan'),
(33, 'Piroxicam'),
(34, 'Ranitidine'),
(35, 'Scabimite'),
(36, 'Simvastatin'),
(37, 'Voltadex'),
(39, 'Generik'),
(40, 'HEXPHARM');

--
-- Triggers `produk_merk`
--
DELIMITER $$
CREATE TRIGGER `cek_duplikat_merk_insert` BEFORE INSERT ON `produk_merk` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT 1 FROM produk_merk WHERE merk = NEW.merk)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'INSERT gagal dikarenkan terdapat duplikasi data';
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cek_duplikat_merk_update` BEFORE UPDATE ON `produk_merk` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT 1 FROM produk_merk WHERE merk = NEW.merk)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'UPDATE gagal dikarenkan terdapat duplikasi data';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `produk_satuan_barang`
--

CREATE TABLE `produk_satuan_barang` (
  `id_satuan_barang` int(4) NOT NULL,
  `satuan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk_satuan_barang`
--

INSERT INTO `produk_satuan_barang` (`id_satuan_barang`, `satuan`) VALUES
(1, 'Botol'),
(2, 'Tube'),
(3, 'kotak'),
(4, 'tablet'),
(5, 'papan'),
(6, 'piece'),
(7, 'strip');

--
-- Triggers `produk_satuan_barang`
--
DELIMITER $$
CREATE TRIGGER `cek_duplikat_satuan_barang_insert` BEFORE INSERT ON `produk_satuan_barang` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT 1 FROM produk_satuan_barang WHERE satuan = NEW.satuan)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'INSERT gagal dikarenkan terdapat duplikasi data';
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cek_duplikat_satuan_barang_update` BEFORE UPDATE ON `produk_satuan_barang` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT 1 FROM produk_satuan_barang WHERE satuan = NEW.satuan)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'UPDATE gagal dikarenkan terdapat duplikasi data';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `produk_satuan_ukuran`
--

CREATE TABLE `produk_satuan_ukuran` (
  `id_satuan_ukuran` int(2) NOT NULL,
  `satuan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk_satuan_ukuran`
--

INSERT INTO `produk_satuan_ukuran` (`id_satuan_ukuran`, `satuan`) VALUES
(1, 'ml'),
(2, 'gr'),
(3, 'kg'),
(4, 'l'),
(5, 'mg');

--
-- Triggers `produk_satuan_ukuran`
--
DELIMITER $$
CREATE TRIGGER `cek_duplikat_satuan_ukuran_insert` BEFORE INSERT ON `produk_satuan_ukuran` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT 1 FROM produk_satuan_ukuran WHERE satuan = NEW.satuan)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'INSERT gagal dikarenkan terdapat duplikasi data';
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cek_duplikat_satuan_ukuran_update` BEFORE UPDATE ON `produk_satuan_ukuran` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT 1 FROM produk_satuan_ukuran WHERE satuan = NEW.satuan)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'UPDATE gagal dikarenkan terdapat duplikasi data';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `produk_stok`
--

CREATE TABLE `produk_stok` (
  `id_stok` int(4) NOT NULL,
  `id_produk` int(4) NOT NULL,
  `stok` int(4) NOT NULL,
  `diubah` char(19) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk_stok`
--

INSERT INTO `produk_stok` (`id_stok`, `id_produk`, `stok`, `diubah`) VALUES
(1, 1, 31, '20-06-2021 20:57:34'),
(3, 2, 13, '20-06-2021 02:57:10'),
(5, 3, 0, '20-06-2021 02:43:06'),
(10, 12, 3, '21-06-2021 12:58:27'),
(11, 13, 13, '21-06-2021 14:49:35'),
(12, 14, 10, '21-06-2021 14:47:52'),
(13, 15, 10, '21-06-2021 14:54:44'),
(14, 16, 10, '21-06-2021 15:23:50'),
(15, 17, 10, '21-06-2021 15:29:43'),
(16, 18, 10, '21-06-2021 15:38:18'),
(17, 19, 10, '21-06-2021 15:49:43'),
(18, 20, 10, '21-06-2021 15:54:18'),
(19, 21, 10, '21-06-2021 15:59:21'),
(20, 22, 10, '21-06-2021 16:01:43'),
(21, 23, 10, '21-06-2021 16:06:42'),
(22, 24, 8, '21-06-2021 16:17:25'),
(23, 25, 8, '21-06-2021 16:21:47'),
(24, 26, 8, '21-06-2021 16:24:21'),
(25, 27, 10, '21-06-2021 17:12:34'),
(26, 28, 10, '21-06-2021 17:16:22'),
(27, 29, 10, '21-06-2021 17:18:45'),
(28, 30, 10, '21-06-2021 17:21:02'),
(29, 31, 10, '21-06-2021 17:23:24'),
(30, 32, 10, '21-06-2021 17:25:36'),
(31, 33, 10, '21-06-2021 17:28:33'),
(32, 34, 10, '21-06-2021 17:32:22'),
(33, 35, 20, '21-06-2021 17:39:29'),
(34, 36, 20, '21-06-2021 17:44:05'),
(35, 37, 20, '21-06-2021 17:50:25'),
(36, 38, 20, '21-06-2021 17:52:58'),
(37, 39, 10, '21-06-2021 17:55:49'),
(38, 40, 10, '21-06-2021 18:03:34'),
(39, 41, 10, '21-06-2021 18:20:12'),
(40, 42, 10, '21-06-2021 18:22:42'),
(41, 43, 10, '21-06-2021 18:24:33'),
(42, 44, 12, '21-06-2021 18:27:36'),
(43, 45, 12, '21-06-2021 18:29:13'),
(44, 46, 5, '21-06-2021 18:30:45'),
(45, 47, 12, '21-06-2021 18:33:05'),
(46, 48, 12, '21-06-2021 18:34:16');

--
-- Triggers `produk_stok`
--
DELIMITER $$
CREATE TRIGGER `insert_log_stok` AFTER UPDATE ON `produk_stok` FOR EACH ROW BEGIN
IF (OLD.stok > NEW.stok) THEN
INSERT INTO log_produk_stok SET id_produk = OLD.id_produk,
aksi = 'Pengurangan',stok_lama = OLD.stok,stok_baru = NEW.stok,timestamp = date_format(now(),'%d-%m-%Y %H:%i:%s');
ELSE
INSERT INTO log_produk_stok SET id_produk = OLD.id_produk,
aksi = 'Penambahan',stok_lama = OLD.stok,stok_baru = NEW.stok,timestamp = date_format(now(),'%d-%m-%Y %H:%i:%s');
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_log_stok_baru` BEFORE INSERT ON `produk_stok` FOR EACH ROW BEGIN
INSERT INTO log_produk_stok
SET id_produk = NEW.id_produk,
aksi = 'Stok Baru',
stok_lama = 0,
stok_baru = NEW.stok,
timestamp = date_format(now(),'%d-%m-%Y %H:%i:%s');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_waktu` BEFORE UPDATE ON `produk_stok` FOR EACH ROW BEGIN
IF (NEW.stok != OLD.stok) THEN
SET NEW.diubah = date_format(now(),'%d-%m-%Y %H:%i:%s');
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `detail_user_pesanan`
--
DROP TABLE IF EXISTS `detail_user_pesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detail_user_pesanan`  AS SELECT `p`.`id_pesanan` AS `id_pesanan`, `a`.`id_akun` AS `id_akun`, `p`.`tanggal` AS `tanggal`, `a`.`nama` AS `nama`, `a`.`no_hp` AS `no_hp`, `a`.`email` AS `email`, `p`.`alamat` AS `alamat`, `p`.`ongkos_kirim` AS `ongkos_kirim`, `p`.`opsi_kirim` AS `opsi_kirim`, `p`.`status` AS `status`, `p`.`resi_pengiriman` AS `resi_pengiriman` FROM (`pesanan` `p` join `akun` `a` on(`p`.`id_akun` = `a`.`id_akun`)) ;

-- --------------------------------------------------------

--
-- Structure for view `listpesanan`
--
DROP TABLE IF EXISTS `listpesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listpesanan`  AS SELECT `p`.`id_akun` AS `id_akun`, `p`.`id_pesanan` AS `id_pesanan`, `p`.`tanggal` AS `tanggal`, `p`.`status` AS `status`, `p`.`ongkos_kirim`+ sum(`hitung_harga_total`(`pd`.`id_produk`,`pd`.`jumlah_beli`)) AS `total_bayar` FROM (`pesanan` `p` join `pesanan_detail` `pd` on(`p`.`id_pesanan` = `pd`.`id_pesanan`)) GROUP BY `p`.`id_pesanan` ;

-- --------------------------------------------------------

--
-- Structure for view `listproduk`
--
DROP TABLE IF EXISTS `listproduk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listproduk`  AS SELECT `p`.`id_produk` AS `id_produk`, `p`.`nama` AS `nama`, `m`.`merk` AS `merk`, `p`.`harga` AS `harga`, `p`.`ukuran` AS `ukuran`, `su`.`satuan` AS `satuan_ukuran`, `s`.`stok` AS `stok`, `s`.`diubah` AS `terakhir_diubah`, `sb`.`satuan` AS `satuan_barang`, `j`.`jenis` AS `jenis`, `p`.`deskripsi` AS `deskripsi`, `p`.`gambar` AS `gambar` FROM ((((((`produk` `p` join `produk_stok` `s` on(`p`.`id_produk` = `s`.`id_produk`)) join `produk_merk` `m` on(`p`.`id_merk` = `m`.`id_merk`)) join `produk_satuan_ukuran` `su` on(`p`.`satuan_ukuran` = `su`.`id_satuan_ukuran`)) join `produk_satuan_barang` `sb` on(`p`.`satuan_barang` = `sb`.`id_satuan_barang`)) left join `produk_jenis` `pj` on(`pj`.`id_produk` = `p`.`id_produk`)) left join `jenis_produk` `j` on(`pj`.`id_jenis` = `j`.`id_jenis`)) ;

-- --------------------------------------------------------

--
-- Structure for view `pembayaran_pesanan`
--
DROP TABLE IF EXISTS `pembayaran_pesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pembayaran_pesanan`  AS SELECT `byr`.`id_pembayaran` AS `id_pembayaran`, `byr`.`id_pesanan` AS `id_pesanan`, `byr`.`pembayar` AS `pembayar`, `byr`.`tanggal` AS `tanggal`, `byr`.`metode` AS `metode`, `byr`.`bukti` AS `bukti`, `ps`.`status` AS `status`, `ps`.`resi_pengiriman` AS `resi_pengiriman` FROM (`pembayaran` `byr` join `pesanan` `ps` on(`byr`.`id_pesanan` = `ps`.`id_pesanan`)) ;

-- --------------------------------------------------------

--
-- Structure for view `pesananproduk`
--
DROP TABLE IF EXISTS `pesananproduk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pesananproduk`  AS SELECT `pd`.`id_pesanan` AS `id_pesanan`, `p`.`nama` AS `nama`, `p`.`harga` AS `harga`, `pd`.`jumlah_beli` AS `jumlah_beli`, `hitung_harga_total`(`pd`.`id_produk`,`pd`.`jumlah_beli`) AS `total` FROM (`produk` `p` join `pesanan_detail` `pd` on(`p`.`id_produk` = `pd`.`id_produk`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akun`
--
ALTER TABLE `akun`
  ADD PRIMARY KEY (`id_akun`),
  ADD KEY `user_db` (`user_db`);

--
-- Indexes for table `akun_db`
--
ALTER TABLE `akun_db`
  ADD PRIMARY KEY (`id_akun_db`);

--
-- Indexes for table `jenis_produk`
--
ALTER TABLE `jenis_produk`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indexes for table `log_edit_profil`
--
ALTER TABLE `log_edit_profil`
  ADD PRIMARY KEY (`id_log_edit_profil`),
  ADD KEY `id_akun` (`id_akun`);

--
-- Indexes for table `log_produk_stok`
--
ALTER TABLE `log_produk_stok`
  ADD PRIMARY KEY (`id_log_produk_stok`),
  ADD KEY `id_produk_stok` (`id_produk`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `id_pesanan` (`id_pesanan`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id_pesanan`),
  ADD KEY `id_akun` (`id_akun`);

--
-- Indexes for table `pesanan_detail`
--
ALTER TABLE `pesanan_detail`
  ADD PRIMARY KEY (`id_detail_pesanan`),
  ADD KEY `id_pesanan` (`id_pesanan`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`),
  ADD KEY `id_satuan` (`satuan_ukuran`),
  ADD KEY `id_merk` (`id_merk`),
  ADD KEY `satuan_barang` (`satuan_barang`);

--
-- Indexes for table `produk_jenis`
--
ALTER TABLE `produk_jenis`
  ADD PRIMARY KEY (`id_produk_jenis`),
  ADD KEY `id_produk` (`id_produk`),
  ADD KEY `id_jenis` (`id_jenis`);

--
-- Indexes for table `produk_merk`
--
ALTER TABLE `produk_merk`
  ADD PRIMARY KEY (`id_merk`);

--
-- Indexes for table `produk_satuan_barang`
--
ALTER TABLE `produk_satuan_barang`
  ADD PRIMARY KEY (`id_satuan_barang`);

--
-- Indexes for table `produk_satuan_ukuran`
--
ALTER TABLE `produk_satuan_ukuran`
  ADD PRIMARY KEY (`id_satuan_ukuran`);

--
-- Indexes for table `produk_stok`
--
ALTER TABLE `produk_stok`
  ADD PRIMARY KEY (`id_stok`),
  ADD KEY `id_produk` (`id_produk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `akun`
--
ALTER TABLE `akun`
  MODIFY `id_akun` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `akun_db`
--
ALTER TABLE `akun_db`
  MODIFY `id_akun_db` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jenis_produk`
--
ALTER TABLE `jenis_produk`
  MODIFY `id_jenis` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `log_edit_profil`
--
ALTER TABLE `log_edit_profil`
  MODIFY `id_log_edit_profil` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `log_produk_stok`
--
ALTER TABLE `log_produk_stok`
  MODIFY `id_log_produk_stok` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id_pesanan` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pesanan_detail`
--
ALTER TABLE `pesanan_detail`
  MODIFY `id_detail_pesanan` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `produk_jenis`
--
ALTER TABLE `produk_jenis`
  MODIFY `id_produk_jenis` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `produk_merk`
--
ALTER TABLE `produk_merk`
  MODIFY `id_merk` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `produk_satuan_barang`
--
ALTER TABLE `produk_satuan_barang`
  MODIFY `id_satuan_barang` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `produk_satuan_ukuran`
--
ALTER TABLE `produk_satuan_ukuran`
  MODIFY `id_satuan_ukuran` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `produk_stok`
--
ALTER TABLE `produk_stok`
  MODIFY `id_stok` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `akun`
--
ALTER TABLE `akun`
  ADD CONSTRAINT `akun_ibfk_1` FOREIGN KEY (`user_db`) REFERENCES `akun_db` (`id_akun_db`);

--
-- Constraints for table `log_edit_profil`
--
ALTER TABLE `log_edit_profil`
  ADD CONSTRAINT `log_edit_profil_ibfk_1` FOREIGN KEY (`id_akun`) REFERENCES `akun` (`id_akun`) ON DELETE CASCADE;

--
-- Constraints for table `log_produk_stok`
--
ALTER TABLE `log_produk_stok`
  ADD CONSTRAINT `log_produk_stok_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE;

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE;

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`id_akun`) REFERENCES `akun` (`id_akun`) ON DELETE CASCADE;

--
-- Constraints for table `pesanan_detail`
--
ALTER TABLE `pesanan_detail`
  ADD CONSTRAINT `pesanan_detail_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE,
  ADD CONSTRAINT `pesanan_detail_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE;

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_2` FOREIGN KEY (`id_merk`) REFERENCES `produk_merk` (`id_merk`) ON DELETE CASCADE,
  ADD CONSTRAINT `produk_ibfk_3` FOREIGN KEY (`satuan_ukuran`) REFERENCES `produk_satuan_ukuran` (`id_satuan_ukuran`) ON DELETE CASCADE,
  ADD CONSTRAINT `produk_ibfk_4` FOREIGN KEY (`satuan_barang`) REFERENCES `produk_satuan_barang` (`id_satuan_barang`) ON DELETE CASCADE;

--
-- Constraints for table `produk_jenis`
--
ALTER TABLE `produk_jenis`
  ADD CONSTRAINT `produk_jenis_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE,
  ADD CONSTRAINT `produk_jenis_ibfk_2` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_produk` (`id_jenis`) ON DELETE CASCADE;

--
-- Constraints for table `produk_stok`
--
ALTER TABLE `produk_stok`
  ADD CONSTRAINT `produk_stok_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
