<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<?php
$id_pesanan = $_GET['id'];

$query=$koneksi->query("SELECT id_pesanan, id_akun, tanggal, nama, no_hp, email, alamat, ongkos_kirim, opsi_kirim 
							FROM detail_user_pesanan WHERE id_pesanan = '$id_pesanan'");
$detail=$query->fetch_assoc();

$subtotalproduk = 0;
?>

<h3>Detail Pesanan Nomor: <?php echo $id_pesanan; ?></h3>

<br>
<hr> 
<div class="row">
	<div class="col-md-4">
		<strong>
			Pesanan #<?php echo $id_pesanan; ?>
		</strong>
		<br>
			Tanggal : <?php echo $detail['tanggal']; ?>
		<br><br>
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
		<b><?= $detail['opsi_kirim'] ?></b>
		<br>
		<?= $detail['alamat'] ?>
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

		$ambildata = $koneksi->query("SELECT nama, harga, jumlah_beli, total FROM pesananproduk WHERE id_pesanan = '$id_pesanan'");

		while ($data = $ambildata->fetch_assoc()) {
	  ?>
		<tr>
			<td><?= $no ?></td>
			<td><?= $data['nama'] ?></td>
			<td>Rp <?= number_format($data['harga']) ?>,-</td>
			<td><?= number_format($data['jumlah_beli']) ?></td>
			<td align="right">Rp <?= number_format($data['total']) ?>,-</td>
		</tr>
	  <?php 

		$subtotalproduk += $data['total'];
		$no++;

		}
	  ?>
</tbody>
</table>
<div>
	Subtotal Produk : Rp <?= number_format($subtotalproduk) ?>,-
	<br>
	Subtotal Pengiriman : Rp <?= number_format($detail['ongkos_kirim']) ?>,-
	<br><br>
	<strong>Total Pembayaran : Rp <?= number_format($subtotalproduk + $detail['ongkos_kirim']) ?>,-</strong>
</div>