<?php
	session_start();

	include 'koneksi.php';

	$datauser = $koneksi->query("SELECT * FROM akun a JOIN pesanan p ON a.id_akun = p.id_akun WHERE p.id_pesanan = '$_GET[id]'")->fetch_assoc();

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
					<strong>Order #<?= $_GET['id'] ?></strong>
					<br>
						Placed on <?= $datauser['tanggal_pesan']; ?>
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
						<b><?= $datauser['opsi_pengiriman'] ?></b>
					<br>
						<?= $datauser['alamat_kirim'] ?>
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

					$ambildata = $koneksi->query("SELECT p.nama_produk, p.harga_produk, por.jumlah_pesanan FROM pesanan_produk por JOIN produk p ON por.id_produk = p.id_produk WHERE por.id_pesanan = '$_GET[id]'");

					while ($data = $ambildata->fetch_assoc()) {
				?>
				<tr>
			  		<td><?= $data['nama_produk'] ?></td>
			  		<td>Rp <?= number_format($data['harga_produk']) ?>,-</td>
			  		<td><?= number_format($data['jumlah_pesanan']) ?></td>
					<td align="right">Rp <?= number_format($data['harga_produk'] * $data['jumlah_pesanan']) ?>,-</td>
			  	</tr>
			  	<?php 
			  		$subtotalproduk += $data['harga_produk'] * $data['jumlah_pesanan'];

					}

					$alltagihan = $subtotalproduk + $datauser['subtotal_pengiriman'];
				?>
			  	<tr><td><br></td></tr>
			  	<tr><td><br></td></tr>
			  	</tbody>
			  	<tfoot>
			  		<tr>
			  			<th colspan="3">Total Pembayaran</th>
			  			<td align="right"><b>Rp <?= number_format($subtotalproduk + $datauser['subtotal_pengiriman']) ?>,-</b> <br> (termasuk ongkir sejumlah Rp <?= number_format($datauser['subtotal_pengiriman']) ?>,-)</td>
			  		</tr>
			  	</tfoot>
			</table>

		</div>
	</div>
</div>

<div style="margin: 15px;">
		<div style="width: 73rem; margin: 30px;">

				<?php if ($datauser['status_pesanan'] == "Pembayaran Berhasil") : ?>
			<div class="alert alert-success" style="width: 73rem; margin-left: 45px">
					<p>Pembayaran berhasil, berikut adalah nomor resi pengiriman Anda. Jika belum ada, harap tunggu maksimal 2 &times; 24 jam atau hubungi contact kami.</p>
				  <strong>
					<p>No. Resi: <?= $datauser['resi_pengiriman'] ?></p>
				  </strong>
			</div>

				<?php elseif ($datauser['status_pesanan'] == "Verifikasi Pembayaran") : ?>
			<div class="alert alert-info" style="width: 73rem; margin-left: 45px">
				<strong>
					<p>Pembayaran diterima, harap menunggu sampai proses pembayaran diverifikasi maksimal 2 &times; 24 jam atau hubungi contact kami.</p>
				  </strong>
			</div>

				<?php elseif ($datauser['status_pesanan'] == "Dibatalkan") : ?>
			<div class="alert alert-danger" style="width: 73rem; margin-left: 45px">
				<strong>
					<p>Pesanan dibatalkan. Harap hubungi contact kami untuk informasi lebih lanjut!</p>
				  </strong>
			</div>

				<?php elseif ($datauser['status_pesanan'] == "Pembayaran Invalid") : ?>
			<div class="alert alert-warning" style="width: 73rem; margin-left: 45px">
				<p>Pembayaran invalid. Silakan melakukan pembayaran kembali sebesar Rp <?= number_format($subtotalproduk + $datauser['subtotal_pengiriman']) ?>,- ke:</p>
					<table style="font-weight: bold;">
					  <strong>
						<tr>
							<td>Bank BNI</td>
							<td>&nbsp;:&nbsp;</td>
							<td>077-922-119-07 a/n. Gabriella Surbakti</td>
						</tr>
						<tr>
							<td>OVO atau Dana</td>
							<td>&nbsp;:&nbsp;</td>
							<td>0895-3425-17290 a/n. Gabriella Surbakti</td>
						</tr>
					  </strong>
					</table>
					<br>
				<p>Atau hubungi contact kami untuk informasi lebih lanjut.</p>
			</div>
			<h6 style="width: 73rem; margin-left: 45px">Sudah melakukan pembayaran kembali? Upload bukti pembayaran <a href="pembayaran.php?id=<?= $_GET['id'] ?>&tagihan=<?= $alltagihan ?>">di sini</a>!</h6>

				<?php else : ?>
			<div class="alert alert-info" style="width: 73rem; margin-left: 45px">
					<p>Silahkan Melakukan Pembayaran sebesar Rp <?= number_format($subtotalproduk + $datauser['subtotal_pengiriman']) ?>,- ke:</p>
					<table style="font-weight: bold;">
					  <strong>
						<tr>
							<td>Bank BNI</td>
							<td>&nbsp;:&nbsp;</td>
							<td>077-922-119-07 a/n. Gabriella Surbakti</td>
						</tr>
						<tr>
							<td>OVO atau Dana</td>
							<td>&nbsp;:&nbsp;</td>
							<td>0895-3425-17290 a/n. Gabriella Surbakti</td>
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