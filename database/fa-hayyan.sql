-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 21, 2021 at 06:19 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

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
(6, 'Obat Batuk');

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
(29, 6, '', 0, 20, '20-06-2021 19:02:50'),
(35, 1, 'Penambahan', 23, 26, '20-06-2021 20:53:10'),
(36, 1, 'Penambahan', 26, 30, '20-06-2021 20:54:01'),
(37, 1, 'Penambahan', 30, 31, '20-06-2021 20:57:34');

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
(3, 5, 'Melinda', '19-06-2021', 'Dana', '19062021215737_nopem_5_typesofinheritance.jpg');

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
(5, 4, '20-06-2021', 'Jalan Kasuari No 69, Kota Aceh Barat Daya, Nanggroe Aceh Darussalam (NAD), 20321', 'Jalur Nugraha Ekakurir (JNE), REG', 27000, 'Belum Dibayar', '-');

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
(11, 5, 2, 1);

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
(6, 3, 'Bisolvon Extra 60 ML', 45000, 60, 1, 1, '<p>Bisolvon Extra merupakan obat yang digunakan untuk mengurangi dan mengencerkan dahak pada saluran pernapasan. Bisolvon mengandung dual zat aktif Bromhexin HCl dan Guaifenesin yang bekerja sebagai iritan pada saluran pernafasan di mana saat batuk, volume mukus ditingkatkan pada saluran napas serta menurunkan viskositasnya (menjadi lebih encer) sehingga dahak/lendir lebih mudah dikeluarkan dari saluran pernapasan. Fungsi kedua zat tersebut adalah ekspektoran yang dapat mengencerkan dahak atau lendir pada saluran pernafasan sehingga lebih mudah dikeluarkan bersamaan dengan batuk.</p>\r\n', '20062021140250_produk_apotek_online_k24klik_20201207105108359225_bisolfon-1.jpg');

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
(6, 3, 4);

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
(3, 'Bisolvon');

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
(2, 'Tube');

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
(2, 'gr');

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
(6, 6, 20, '20-06-2021 19:02:50');

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

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detail_user_pesanan`  AS  select `p`.`id_pesanan` AS `id_pesanan`,`a`.`id_akun` AS `id_akun`,`p`.`tanggal` AS `tanggal`,`a`.`nama` AS `nama`,`a`.`no_hp` AS `no_hp`,`a`.`email` AS `email`,`p`.`alamat` AS `alamat`,`p`.`ongkos_kirim` AS `ongkos_kirim`,`p`.`opsi_kirim` AS `opsi_kirim`,`p`.`status` AS `status`,`p`.`resi_pengiriman` AS `resi_pengiriman` from (`pesanan` `p` join `akun` `a` on(`p`.`id_akun` = `a`.`id_akun`)) ;

-- --------------------------------------------------------

--
-- Structure for view `listpesanan`
--
DROP TABLE IF EXISTS `listpesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listpesanan`  AS  select `p`.`id_akun` AS `id_akun`,`p`.`id_pesanan` AS `id_pesanan`,`p`.`tanggal` AS `tanggal`,`p`.`status` AS `status`,`p`.`ongkos_kirim` + sum(`hitung_harga_total`(`pd`.`id_produk`,`pd`.`jumlah_beli`)) AS `total_bayar` from (`pesanan` `p` join `pesanan_detail` `pd` on(`p`.`id_pesanan` = `pd`.`id_pesanan`)) group by `p`.`id_pesanan` ;

-- --------------------------------------------------------

--
-- Structure for view `listproduk`
--
DROP TABLE IF EXISTS `listproduk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listproduk`  AS  select `p`.`id_produk` AS `id_produk`,`p`.`nama` AS `nama`,`m`.`merk` AS `merk`,`p`.`harga` AS `harga`,`p`.`ukuran` AS `ukuran`,`su`.`satuan` AS `satuan_ukuran`,`s`.`stok` AS `stok`,`s`.`diubah` AS `terakhir_diubah`,`sb`.`satuan` AS `satuan_barang`,`j`.`jenis` AS `jenis`,`p`.`deskripsi` AS `deskripsi`,`p`.`gambar` AS `gambar` from ((((((`produk` `p` join `produk_stok` `s` on(`p`.`id_produk` = `s`.`id_produk`)) join `produk_merk` `m` on(`p`.`id_merk` = `m`.`id_merk`)) join `produk_satuan_ukuran` `su` on(`p`.`satuan_ukuran` = `su`.`id_satuan_ukuran`)) join `produk_satuan_barang` `sb` on(`p`.`satuan_barang` = `sb`.`id_satuan_barang`)) left join `produk_jenis` `pj` on(`pj`.`id_produk` = `p`.`id_produk`)) left join `jenis_produk` `j` on(`pj`.`id_jenis` = `j`.`id_jenis`)) ;

-- --------------------------------------------------------

--
-- Structure for view `pembayaran_pesanan`
--
DROP TABLE IF EXISTS `pembayaran_pesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pembayaran_pesanan`  AS  select `byr`.`id_pembayaran` AS `id_pembayaran`,`byr`.`id_pesanan` AS `id_pesanan`,`byr`.`pembayar` AS `pembayar`,`byr`.`tanggal` AS `tanggal`,`byr`.`metode` AS `metode`,`byr`.`bukti` AS `bukti`,`ps`.`status` AS `status`,`ps`.`resi_pengiriman` AS `resi_pengiriman` from (`pembayaran` `byr` join `pesanan` `ps` on(`byr`.`id_pesanan` = `ps`.`id_pesanan`)) ;

-- --------------------------------------------------------

--
-- Structure for view `pesananproduk`
--
DROP TABLE IF EXISTS `pesananproduk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pesananproduk`  AS  select `pd`.`id_pesanan` AS `id_pesanan`,`p`.`nama` AS `nama`,`p`.`harga` AS `harga`,`pd`.`jumlah_beli` AS `jumlah_beli`,`hitung_harga_total`(`pd`.`id_produk`,`pd`.`jumlah_beli`) AS `total` from (`produk` `p` join `pesanan_detail` `pd` on(`p`.`id_produk` = `pd`.`id_produk`)) ;

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
  MODIFY `id_jenis` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `log_edit_profil`
--
ALTER TABLE `log_edit_profil`
  MODIFY `id_log_edit_profil` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `log_produk_stok`
--
ALTER TABLE `log_produk_stok`
  MODIFY `id_log_produk_stok` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id_pesanan` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pesanan_detail`
--
ALTER TABLE `pesanan_detail`
  MODIFY `id_detail_pesanan` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `produk_jenis`
--
ALTER TABLE `produk_jenis`
  MODIFY `id_produk_jenis` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `produk_merk`
--
ALTER TABLE `produk_merk`
  MODIFY `id_merk` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `produk_satuan_barang`
--
ALTER TABLE `produk_satuan_barang`
  MODIFY `id_satuan_barang` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `produk_satuan_ukuran`
--
ALTER TABLE `produk_satuan_ukuran`
  MODIFY `id_satuan_ukuran` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `produk_stok`
--
ALTER TABLE `produk_stok`
  MODIFY `id_stok` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
