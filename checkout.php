<?php
	session_start();

	include 'koneksi.php';

	if (!isset($_SESSION['customer']) || empty($_SESSION['customer'])) {
		echo "<script>alert('Silakan login terlebih dahulu!')</script>";
		echo "<script> window.location.href = 'login.php'; </script>";
	}
	else if (!isset($_SESSION['cart']) || empty($_SESSION['cart']) || !empty($_SESSION['cart']) == 0) {
		echo "<script>alert('Keranjang kamu kosong!')</script>";
		echo "<script> window.location.href = 'allstuff.php'; </script>";
	}
	else if ($_SESSION['customer']['alamat'] == '') {
		echo "<script>alert('Harap isi alamat kamu terlebih dahulu!')</script>";
		echo "<script> window.location.href = 'edit_profil.php'; </script>";
	}

		$layanan = '';
		$kurir = '';
		$tujuan = '';
		$jenisLayanan = '';
		$tarif = 0;

	if (!isset($_POST['submitOngkir']) && !isset($_POST['checkout'])) {
		echo "<script> window.location.href = 'keranjang.php'; </script>";
	}
	else if (isset($_POST['pilOngkir'])) {

		$layanan = explode(",", $_POST['pilOngkir']);

		$kurir = $_POST['kurir'];
		$tujuan = $_POST['kotaTujuan'].", ".$_POST['provTujuan'];
		$jenisLayanan = $layanan[0];
		$tarif = $layanan[1];

		$_SESSION['shipping']['kurir'] = $kurir;
		$_SESSION['shipping']['tujuan'] = $tujuan;
		$_SESSION['shipping']['jenisLayanan'] = $jenisLayanan;
		$_SESSION['shipping']['tarif'] = $tarif;

	}

	// $alamatLengkap = $_SESSION['customer']['alamat'].", Kota ".$tujuan.", ".$_SESSION['customer']['kode_pos'];

?>

<!DOCTYPE html>
<html>
<head>
	<link rel="icon" type="image/*" href="icon/fa_hayyan.png">
	<title>FA-HAYYAN</title>
	<?php include 'scrsty.php'; ?>

	<style type="text/css">
      .btn-kustom {
        color: #fff;
        background-color: #5d8975;
        border-color: #5d8975;
      }

      .btn-kustom:hover {
        color: #fff;
        background-color: #48695a;
        border-color: #48695a;
      }
    </style>
</head>
<body>

	<?php include 'navbar.php'; ?>

<div style="margin: 15px" align="center">
	  <div class="card" style="width: 73rem; margin: 30px;">
		<div class="card-body">
		  
			<h5>Opsi Pengiriman</h5>
			<br><br>
			<table width="100%">
				<tr>
					<th>Kurir</th>
					<th>Alamat Pengiriman</th>
					<th>Jenis Layanan</th>
					<th>Tarif</th>
				</tr>
				<tr><td><br></td></tr>
				<tr>
					<td style="width: 300px;"><?= $kurir ?></td>
					<td style="width: 650px;"><?= $_SESSION['customer']['alamat'] ?>,<br>Kota <?= $tujuan ?>, <?= $_SESSION['customer']['kode_pos'] ?></td>
					<td style="width: 150px;"><?= $jenisLayanan ?></td>
					<td style="width: 140px;">Rp <?= number_format($tarif) ?>,-</td>
				</tr>
				<tr><td><br></td></tr>
				<tr><td><br></td></tr>
				<tr><td><br></td></tr>
				<tr>
			  		<th colspan="3">Subtotal untuk Pengiriman</th>
			  		<th>Rp <?= number_format($tarif) ?>,-</th>
			  	</tr>
			</table>

		</div>
	</div>
</div>

	<div style="margin: 15px" align="center">
	  <div class="card" style="width: 73rem; margin: 30px;">
		<div class="card-body">
			<table width="100%" class="table table-borderless">
			  <thead>
			    <tr>
			      <th>No</th>
			      <th>Produk</th>
			      <th></th>
			      <th align="center">Harga Satuan</th>
			      <th align="center">Jumlah</th>
			      <th style="text-align: center;">&nbsp;&nbsp;&nbsp;&nbsp;Subtotal</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<?php
			  	   $subtotalBarang = 0;
			  	   $no = 1;
			  	   foreach ($_SESSION['cart'] as $id => $jumlah): 
			  	?>
			  	<?php 
			  		$data = $koneksi->query("SELECT id_produk, nama_produk, foto_produk, harga_produk FROM produk WHERE id_produk = '$id'")->fetch_assoc();
			  		$subharga = $data['harga_produk'] * $jumlah;
			  	?>
			  	<tr>
			  		<td><?= $no ?></td>
			  		<td><a href="detail.php?id=<?php echo $id ?>"><img width="100px" src="image/<?php echo $data['foto_produk'] ?>"></a></td>
			      	<td><a style="color: inherit; text-decoration: none;" href="detail.php?id=<?php echo $id ?>"><?php echo $data['nama_produk']; ?></a></td>
			  		<td align="center">Rp <?php echo number_format($data['harga_produk']); ?>,-</td>
			  		<td align="center"><?= number_format($jumlah) ?></td>
			  		<td align="right">Rp <?= number_format($subharga) ?>,-</td>
			  	</tr>
			  	<?php 
			  		$subtotalBarang += $subharga;
			  		$no++;
			  	?>
			  	<?php endforeach ?>
			  </tbody>
			  <tfoot>
			  	<tr>
			  		<th colspan="5">Subtotal untuk Produk</th>
			  		<th style="text-align: right;">Rp <?= number_format($subtotalBarang) ?>,-</th>
			  	</tr>
			  </tfoot>
			</table>
		</div>
	</div>
</div>

<div style="margin: 15px" align="center">
	  <div class="card" style="width: 73rem; margin: 30px;">
		<div class="card-body">
			<table width="100%">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			  	<tr>
			  		<td colspan="5">Subtotal untuk Pengiriman</td>
			  		<td align="right">Rp <?= number_format($tarif) ?>,-</td>
			  	</tr>
			  	<tr>
			  		<td colspan="5">Subtotal untuk Produk</td>
			  		<td align="right">Rp <?= number_format($subtotalBarang) ?>,-</td>
			  	</tr>
			  	<tr><td><br></td></tr>
			  	<tr>
			  		<?php $totalbayar = $subtotalBarang + $tarif; ?>

			  		<th colspan="5">TOTAL PEMBAYARAN</th>
			  		<th style="color: #48695a; text-align: right;">Rp <?= number_format($totalbayar) ?>,-</th>
			  	</tr>
			</table>
		</div>
	</div>
</div>
	
<div style="margin: 15px" align="center">
	  <div class="card" style="width: 73rem; margin: 30px; border-style: none;">
	  	  <form method="post">
			<button type="submit" name="checkout" class="btn btn-kustom btn-sm btn-block">Buat Pesanan</button>
		  </form>
		  	<br>
			<a href="checkout_ongkir.php" class="btn btn-outline-secondary btn-sm btn-block">Batal</a>
		</div>
	</div>
</div>

	<?php include 'footer.php'; ?>

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.min.css'>

	<?php

		if (isset($_POST['checkout'])) {

			$id_pemesan = $_SESSION['customer']['id_akun'];
			$tanggal_pemesanan = date("d-m-Y");
			$subtotal_produk = $subtotalBarang;
			$alamat_kirim = $_SESSION['customer']['alamat'].", Kota ".$_SESSION['shipping']['tujuan'].", ".$_SESSION['customer']['kode_pos'];
			$opsi_pengiriman = $_SESSION['shipping']['kurir'].", ".$_SESSION['shipping']['jenisLayanan'];
			$subtotal_pengiriman = $_SESSION['shipping']['tarif'];

			$koneksi->query("INSERT INTO pesanan (id_akun, tanggal_pesan, subtotal_produk, alamat_kirim, opsi_pengiriman, subtotal_pengiriman)
								          VALUES ('$id_pemesan', '$tanggal_pemesanan', '$subtotal_produk', '$alamat_kirim', '$opsi_pengiriman', '$subtotal_pengiriman')");

			$id_pesanan = $koneksi->insert_id;

			foreach ($_SESSION['cart'] as $id_produk => $jumlah) {
				$koneksi->query("INSERT INTO pesanan_produk (id_pesanan, id_produk, jumlah_pesanan)
													VALUES ('$id_pesanan', '$id_produk', '$jumlah')");

				$koneksi->query("UPDATE produk SET stok_produk = stok_produk-$jumlah WHERE id_produk = '$id_produk'");
			}

			unset($_SESSION['cart']);
			unset($_SESSION['shipping']);

			echo  '<script type="text/javascript">
                        swal({title: "Checkout Berhasil!", 
                          text: "Yuk, segera lakukan pembayaran!", 
                          icon: "success"
                        }).then(function() {
                          window.location = "nota.php?id='.$id_pesanan.'";
                        });
                     </script>';
		}

	?>

</body>
</html>