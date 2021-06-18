-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 18, 2021 at 09:59 PM
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
(3, 2, 'arsyfpro@email.com', '123456789', 'Arsya Pro', 'Jl. Medan-Binjai km 13,5', '20351', '081234567890');

--
-- Triggers `akun`
--
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
  `akun` varchar(10) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `akun_db`
--

INSERT INTO `akun_db` (`id_akun_db`, `akun`, `username`, `password`) VALUES
(1, 'admin', 'admin', 'admin123'),
(2, 'customer', 'customer', 'customer123');

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
(4, 'Salep');

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
(2, 3, 'Arsya Pro', 'Arsya Pro', 'Jl. Johor Baru Medan Johor', 'Jl. Medan-Binjai km 13,5', '20351', '20351', '081234567890', '081234567890', '19-06-2021 01:20:00');

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
(21, 3, 'Stok Baru', 0, 20, '18-06-2021 19:16:32'),
(22, 3, 'Pengurangan', 20, 0, '18-06-2021 19:16:56'),
(23, 3, 'Penambahan', 0, 3, '18-06-2021 20:17:45'),
(24, 1, 'Pengurangan', 25, 24, '19-06-2021 02:48:17'),
(25, 3, 'Pengurangan', 3, 2, '19-06-2021 02:58:37');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(6) NOT NULL,
  `id_pesanan` int(5) NOT NULL,
  `pembayar` varchar(50) NOT NULL,
  `tanggal` char(10) NOT NULL,
  `metode` enum('BRI','OVO','Dana','Gopay') NOT NULL,
  `bukti` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `status` enum('Belum Dibayar','Dibayar','Dikirim') NOT NULL DEFAULT 'Belum Dibayar',
  `resi_pengiriman` varchar(50) NOT NULL DEFAULT '-'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id_pesanan`, `id_akun`, `tanggal`, `alamat`, `opsi_kirim`, `ongkos_kirim`, `status`, `resi_pengiriman`) VALUES
(1, 2, '18-06-2021', 'Jalan Medan Binjai km 13,5', 'JNE', 7000, 'Belum Dibayar', '-'),
(2, 3, '18-06-2021', 'Jl. Medan-Binjai km 13,5, Kota Medan, Sumatera Utara, 20351', 'Jalur Nugraha Ekakurir (JNE), CTC', 7000, 'Belum Dibayar', '-'),
(3, 3, '19-06-2021', 'Jl. Medan-Binjai km 13,5, Kota Medan, Sumatera Utara, 20351', 'Jalur Nugraha Ekakurir (JNE), CTC', 7000, 'Belum Dibayar', '-');

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
(6, 1, 1, 1),
(7, 2, 1, 1),
(8, 3, 3, 1);

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
(1, 1, 'BETADINE GARGLE 190 ML', 32000, 190, 1, 1, 'Obat kumur antiseptik untuk rongga mulut seperti gigi berlubang, gusi bengkak, sakit tenggorokan, sariawan, bau mulut dan nafas tak segar', 'apotek_online_k24klik_20201127090840359225_BETADINE-BIRU.jpg'),
(2, 1, 'BETADINE GARGLE 100 ML', 17000, 100, 1, 1, 'Obat kumur antiseptik untuk rongga mulut seperti gigi berlubang, gusi bengkak, sakit tenggorokan, sariawan, bau mulut dan nafas tak segar', 'apotek_online_k24klik_201904291011331242_BETADINE.jpg'),
(3, 1, 'BETADINE OINT 20 GR', 30000, 20, 2, 2, 'Salep luka yang dapat digunakan untuk luka terbuka maupun luka bakar.', 'apotek_online_k24klik_20200711015219359225_BETADIN-20G-1.jpg');

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
(1, 1, 2),
(2, 1, 1),
(3, 2, 1),
(4, 2, 2),
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
(1, 'Betadine');

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
(1, 1, 24, '19-06-2021 02:48:17'),
(3, 2, 14, '18-06-2021 18:17:02'),
(5, 3, 2, '19-06-2021 02:58:37');

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
-- Structure for view `listproduk`
--
DROP TABLE IF EXISTS `listproduk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listproduk`  AS  select `p`.`id_produk` AS `id_produk`,`p`.`nama` AS `nama`,`m`.`merk` AS `merk`,`p`.`harga` AS `harga`,`p`.`ukuran` AS `ukuran`,`su`.`satuan` AS `satuan_ukuran`,`s`.`stok` AS `stok`,`s`.`diubah` AS `terakhir_diubah`,`sb`.`satuan` AS `satuan_barang`,`j`.`jenis` AS `jenis`,`p`.`deskripsi` AS `deskripsi`,`p`.`gambar` AS `gambar` from ((((((`produk` `p` join `produk_stok` `s` on(`p`.`id_produk` = `s`.`id_produk`)) join `produk_merk` `m` on(`p`.`id_merk` = `m`.`id_merk`)) join `produk_satuan_ukuran` `su` on(`p`.`satuan_ukuran` = `su`.`id_satuan_ukuran`)) join `produk_satuan_barang` `sb` on(`p`.`satuan_barang` = `sb`.`id_satuan_barang`)) join `produk_jenis` `pj` on(`pj`.`id_produk` = `p`.`id_produk`)) join `jenis_produk` `j` on(`pj`.`id_jenis` = `j`.`id_jenis`)) ;

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
  MODIFY `id_akun` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `akun_db`
--
ALTER TABLE `akun_db`
  MODIFY `id_akun_db` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jenis_produk`
--
ALTER TABLE `jenis_produk`
  MODIFY `id_jenis` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `log_edit_profil`
--
ALTER TABLE `log_edit_profil`
  MODIFY `id_log_edit_profil` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `log_produk_stok`
--
ALTER TABLE `log_produk_stok`
  MODIFY `id_log_produk_stok` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id_pesanan` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pesanan_detail`
--
ALTER TABLE `pesanan_detail`
  MODIFY `id_detail_pesanan` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `produk_jenis`
--
ALTER TABLE `produk_jenis`
  MODIFY `id_produk_jenis` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `produk_merk`
--
ALTER TABLE `produk_merk`
  MODIFY `id_merk` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id_stok` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
