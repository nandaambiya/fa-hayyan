<?php
	session_start();

	include 'koneksi.php';

	$id_pesanan = $_GET['id'];

	$datauser = $koneksi->query("SELECT * FROM detail_user_pesanan WHERE id_pesanan = '$id_pesanan'")->fetch_assoc();

	if ($datauser['id_akun'] != $_SESSION['customer']['id_akun']) {
		echo "<script>location='login.php'</script>";
	}

?>

<!DOCTYPE html>
<html>
<head>
	<title>FA-HAYYAN</title>
	<link rel="icon" type="image/*" href="icon/fa_hayyan.png">
	<?php include 'scrsty.php'; ?>
	<style>
		.table-borderless > tbody > tr > td,
		.table-borderless > tbody > tr > th,
		.table-borderless > tfoot > tr > td,
		.table-borderless > tfoot > tr > th,
		.table-borderless > thead > tr > td,
		.table-borderless > thead > tr > th {
		    border: none;
		}
	</style>
</head>
<body>

<?php include 'navbar.php'; ?>

<div style="margin: 15px" align="center">
	  <div class="card" style="width: 73rem; margin: 30px;">
		<div style="padding-left: 100px; padding-right: 100px"  class="card-body">
			<div style="text-align: left !important;" class="row">
				<div class="col-md-4">
					<strong>Pesanan #<?= $id_pesanan ?></strong>
					<br>
						Dipesan pada <?= $datauser['tanggal']; ?>
				</div>

				<div class="col-md-4">
					<strong>
						<?= $datauser['nama'] ?>
					</strong>
					<br>
					<p>
						<?= $datauser['no_hp'] ?><br>
						<?= $datauser['email'] ?>
					</p>
				</div>

				<div class="col-md-4">
						<b><?= $datauser['opsi_kirim'] ?></b>
					<br>
						<?= $datauser['alamat'] ?>
					<br>
				</div>
			</div>
			<br><br>
			<table width="100%" class="table table-sm table-borderless">
				<thead>
					<th>Produk</th>
					<th>Harga Satuan</th>
					<th>Jumlah</th>
					<th style="text-align: right;">Total</th>
				</thead>
				<tbody>
				<?php
					$subtotalproduk = 0;

					$ambildata = $koneksi->query("SELECT nama, harga, jumlah_beli, total FROM pesananproduk WHERE id_pesanan = '$id_pesanan'");

					while ($data = $ambildata->fetch_assoc()) {
				?>
				<tr>
			  		<td><?= $data['nama'] ?></td>
			  		<td>Rp <?= number_format($data['harga']) ?>,-</td>
			  		<td><?= number_format($data['jumlah_beli']) ?></td>
					<td align="right">Rp <?= number_format($data['total']) ?>,-</td>
			  	</tr>
			  	<?php 
			  			$subtotalproduk += $data['total'];
					}

					$alltagihan = $subtotalproduk + $datauser['ongkos_kirim'];
				?>
			  	<tr><td><br></td></tr>
			  	<tr><td><br></td></tr>
			  	</tbody>
			  	<tfoot>
			  		<tr>
			  			<th colspan="3">Total Pembayaran</th>
			  			<td align="right">
			  				<b>Rp <?= number_format($alltagihan) ?>,-</b> <br> (termasuk ongkir sejumlah Rp <?= number_format($datauser['ongkos_kirim']) ?>,-)
			  			</td>
			  		</tr>
			  	</tfoot>
			</table>

		</div>
	</div>
</div>

<div style="margin: 15px;" align="center">
		<div align="left" style="width: 73rem; margin: 30px;">

				<?php if ($datauser['status'] == "Dikirim") : ?>
			<div class="alert alert-success" style="width: 73rem; margin-left: 45px">
					<p>
						Pembayaran berhasil, berikut adalah nomor resi pengiriman Anda. Jika belum ada, harap tunggu maksimal 2 &times; 24 jam atau hubungi kontak kami.
					</p>
				  <strong>
					<p>No. Resi: <?= $datauser['resi_pengiriman'] ?></p>
				  </strong>
			</div>

				<?php elseif ($datauser['status'] == "Dibayar") : ?>
			<div class="alert alert-info" style="width: 73rem; margin-left: 45px">
				<strong>
					<p>
						Pembayaran diterima, harap menunggu sampai pesanan dikirimkan maksimal 2 &times; 24 jam atau hubungi kontak kami.
					</p>
				</strong>
			</div>

				<?php elseif ($datauser['status'] == "Dibatalkan") : ?>
			<div class="alert alert-danger" style="width: 73rem; margin-left: 45px">
				<strong>
					<p>Pesanan dibatalkan. Harap hubungi kontak kami untuk informasi lebih lanjut!</p>
				</strong>
			</div>

				<?php elseif ($datauser['status'] == "Pembayaran Invalid") : ?>
			<div class="alert alert-warning" style="width: 73rem; margin-left: 45px">
				<p>Pembayaran invalid. Silakan melakukan pembayaran kembali sebesar Rp <?= number_format($alltagihan) ?>,- ke:</p>
					<table style="font-weight: bold;">
					  <strong>
						<tr>
							<td>Bank BNI</td>
							<td>&nbsp;:&nbsp;</td>
							<td>122-874-099-4</td>
							<td>&nbsp;</td>
							<td>a/n. Aufa</td>
						</tr>
						<tr>
							<td>Gopay, Dana, atau OVO</td>
							<td>&nbsp;:&nbsp;</td>
							<td>0813-9337-6056</td>
							<td>&nbsp;</td>
							<td>a/n. Aufa</td>
						</tr>
					  </strong>
					</table>
					<br>
				<p>Atau hubungi kontak kami untuk informasi lebih lanjut.</p>
			</div>
			<h6 style="width: 73rem; margin-left: 45px">Sudah melakukan pembayaran kembali? Upload bukti pembayaran <a href="pembayaran.php?id=<?= $_GET['id'] ?>&tagihan=<?= $alltagihan ?>">di sini</a>!</h6>

				<?php else : ?>
			<div class="alert alert-info" style="width: 73rem; margin-left: 45px">
					<p>Silahkan Melakukan Pembayaran sebesar Rp <?= number_format($alltagihan) ?>,- ke:</p>
					<table style="font-weight: bold;">
					  <strong>
						<tr>
							<td>Bank BNI</td>
							<td>&nbsp;:&nbsp;</td>
							<td>122-874-099-4</td>
							<td>&nbsp;</td>
							<td>a/n. Aufa</td>
						</tr>
						<tr>
							<td>Gopay, Dana, atau OVO</td>
							<td>&nbsp;:&nbsp;</td>
							<td>0813-9337-6056</td>
							<td>&nbsp;</td>
							<td>a/n. Aufa</td>
						</tr>
					  </strong>
					</table>
			</div>
					<h6 style="width: 73rem; margin-left: 45px">Sudah melakukan pembayaran? Upload bukti pembayaran <a href="pembayaran.php?id=<?= $_GET['id'] ?>&tagihan=<?= $alltagihan ?>">di sini</a>!</h6>
				<?php endif ?>
		</div>
</div>

<?php include 'footer.php'; ?>

</body>
</html>