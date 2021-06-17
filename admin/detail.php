<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<?php
$nopesanan = $_GET['id'];

$query=$koneksi->query("SELECT * FROM pesanan JOIN akun ON pesanan.id_akun=akun.id_akun WHERE pesanan.id_pesanan = '$nopesanan'");
$detail=$query->fetch_assoc();
?>

<h3>Detail Pesanan Nomor: <?php echo $nopesanan; ?></h3>

<br>
<hr>
<div class="row">
	<div class="col-md-4">
		<strong>
			Pesanan #<?php echo $detail['id_pesanan']; ?>
		</strong>
		<br>
			Tanggal : <?php echo $detail['tanggal_pesan']; ?>
		<br><br>
			Subtotal Produk : Rp <?= number_format($detail['subtotal_produk']) ?>,-
			<br>
			Subtotal Pengiriman : Rp <?= number_format($detail['subtotal_pengiriman']) ?>,-
			<br><br>
			<strong>Total Pembayaran : Rp <?= number_format($detail['subtotal_produk'] + $detail['subtotal_pengiriman']) ?>,-</strong>
	</div>

	<div class="col-md-4">
		<strong>
			<?= $detail['nama'] ?>
		</strong>
		<br>
			<?= $detail['no_hp'] ?><br>
			<?= $detail['email'] ?>
	</div>

	<div class="col-md-4">
		<b><?= $detail['opsi_pengiriman'] ?></b>
		<br>
		<?= $detail['alamat_kirim'] ?>
		<br>
	</div>
</div>
<br>
<br>
<h3>Detail Produk</h3>
<br>
<table class="table table-bordered">
	<thead>
	<tr>
		<th>No. </th>
		<th>Produk</th>
		<th>Harga Satuan</th>
		<th>Jumlah</th>
		<th>Total</th>
	</tr>
	</thead>
	<tbody>
	  <?php
	  	$no = 1;
		$subtotalproduk = 0;

		$ambildata = $koneksi->query("SELECT p.nama_produk, p.harga_produk, por.jumlah_pesanan FROM pesanan_produk por JOIN produk p ON por.id_produk = p.id_produk WHERE por.id_pesanan = '$_GET[id]'");

		while ($data = $ambildata->fetch_assoc()) {
	  ?>
		<tr>
			<td><?= $no ?></td>
			<td><?= $data['nama_produk'] ?></td>
			<td>Rp <?= number_format($data['harga_produk']) ?>,-</td>
			<td><?= number_format($data['jumlah_pesanan']) ?></td>
			<td align="right">Rp <?= number_format($data['harga_produk'] * $data['jumlah_pesanan']) ?>,-</td>
		</tr>
	  <?php 

		$subtotalproduk += $data['harga_produk'] * $data['jumlah_pesanan'];
		$no++;

		}
	  ?>
</tbody>
</table>