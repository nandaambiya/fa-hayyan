-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 18, 2021 at 09:06 AM
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
(2, 2, 'arsya@mail.com', '123456789', 'Arsya Fikri', 'Jalan Medan Binjai km 13,5', '20351', '082275801234');

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
-- Table structure for table `detail_pesanan`
--

CREATE TABLE `detail_pesanan` (
  `id_detail_pesanan` int(6) NOT NULL,
  `id_pesanan` int(5) NOT NULL,
  `id_produk` int(4) NOT NULL,
  `jumlah_beli` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `jenis_produk`
--

CREATE TABLE `jenis_produk` (
  `id_jenis` int(3) NOT NULL,
  `jenis` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `log_produk_stok`
--

CREATE TABLE `log_produk_stok` (
  `id_log_produk_stok` int(5) NOT NULL,
  `id_produk_stok` int(4) NOT NULL,
  `aksi` enum('Penambahan','Pengurangan') NOT NULL,
  `stok_lama` int(4) NOT NULL,
  `stok_baru` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `kode_pos` char(5) NOT NULL,
  `kurir` varchar(100) NOT NULL,
  `ongkos_kurir` int(10) NOT NULL,
  `status` enum('Belum Dibayar','Dibayar','Dikirim') NOT NULL DEFAULT 'Belum Dibayar',
  `resi_pengiriman` varchar(50) NOT NULL DEFAULT '-'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `porduk_stok`
--

CREATE TABLE `porduk_stok` (
  `id_stok` int(4) NOT NULL,
  `id_produk` int(4) NOT NULL,
  `stok` int(4) NOT NULL,
  `diubah` char(19) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `id_satuan` int(2) NOT NULL,
  `deskripsi` text NOT NULL,
  `gambar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `produk_jenis`
--

CREATE TABLE `produk_jenis` (
  `id_produk_jenis` int(5) NOT NULL,
  `id_produk` int(4) NOT NULL,
  `id_jenis` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `produk_merk`
--

CREATE TABLE `produk_merk` (
  `id_merk` int(4) NOT NULL,
  `merk` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `produk_satuan_ukuran`
--

CREATE TABLE `produk_satuan_ukuran` (
  `id_satuan` int(2) NOT NULL,
  `satuan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Indexes for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD PRIMARY KEY (`id_detail_pesanan`),
  ADD KEY `id_pesanan` (`id_pesanan`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `jenis_produk`
--
ALTER TABLE `jenis_produk`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indexes for table `log_produk_stok`
--
ALTER TABLE `log_produk_stok`
  ADD PRIMARY KEY (`id_log_produk_stok`),
  ADD KEY `id_produk_stok` (`id_produk_stok`);

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
-- Indexes for table `porduk_stok`
--
ALTER TABLE `porduk_stok`
  ADD PRIMARY KEY (`id_stok`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`),
  ADD KEY `id_satuan` (`id_satuan`),
  ADD KEY `id_merk` (`id_merk`);

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
-- Indexes for table `produk_satuan_ukuran`
--
ALTER TABLE `produk_satuan_ukuran`
  ADD PRIMARY KEY (`id_satuan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `akun`
--
ALTER TABLE `akun`
  MODIFY `id_akun` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `akun_db`
--
ALTER TABLE `akun_db`
  MODIFY `id_akun_db` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  MODIFY `id_detail_pesanan` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jenis_produk`
--
ALTER TABLE `jenis_produk`
  MODIFY `id_jenis` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_produk_stok`
--
ALTER TABLE `log_produk_stok`
  MODIFY `id_log_produk_stok` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id_pesanan` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `porduk_stok`
--
ALTER TABLE `porduk_stok`
  MODIFY `id_stok` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produk_jenis`
--
ALTER TABLE `produk_jenis`
  MODIFY `id_produk_jenis` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produk_merk`
--
ALTER TABLE `produk_merk`
  MODIFY `id_merk` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produk_satuan_ukuran`
--
ALTER TABLE `produk_satuan_ukuran`
  MODIFY `id_satuan` int(2) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `akun`
--
ALTER TABLE `akun`
  ADD CONSTRAINT `akun_ibfk_1` FOREIGN KEY (`user_db`) REFERENCES `akun_db` (`id_akun_db`);

--
-- Constraints for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD CONSTRAINT `detail_pesanan_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE,
  ADD CONSTRAINT `detail_pesanan_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE;

--
-- Constraints for table `log_produk_stok`
--
ALTER TABLE `log_produk_stok`
  ADD CONSTRAINT `log_produk_stok_ibfk_1` FOREIGN KEY (`id_produk_stok`) REFERENCES `porduk_stok` (`id_stok`) ON DELETE CASCADE;

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
-- Constraints for table `porduk_stok`
--
ALTER TABLE `porduk_stok`
  ADD CONSTRAINT `porduk_stok_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE;

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`id_satuan`) REFERENCES `produk_satuan_ukuran` (`id_satuan`) ON DELETE CASCADE,
  ADD CONSTRAINT `produk_ibfk_2` FOREIGN KEY (`id_merk`) REFERENCES `produk_merk` (`id_merk`) ON DELETE CASCADE;

--
-- Constraints for table `produk_jenis`
--
ALTER TABLE `produk_jenis`
  ADD CONSTRAINT `produk_jenis_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE,
  ADD CONSTRAINT `produk_jenis_ibfk_2` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_produk` (`id_jenis`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
