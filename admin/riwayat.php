<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<?php
$uname = $_GET['username'];
?>

<h3>Riwayat Belanja <?php echo "$uname"; ?></h3>
<table class="table table-bordered">
	<thead>
		<tr>
			<th>No.</th>
			<th>No. Pesanan</th>
			<th>Tanggal Pemesanan</th>
			<th>Total Pembayaran</th>
			<th>Area COD</th>
			<th>Biaya COD</th>
			<th>Status</th>
		</tr>
	</thead>
	<tbody>
		<?php 
		$no = 1;
		$query = $koneksi->query("SELECT * FROM pemesanan WHERE username = '$uname'");
		while($data = $query->fetch_assoc()){
		?>
		<tr>
			<td><?php echo "$no"; ?></td>
			<td><?php echo "$data[no_pemesanan]"; ?></td>
			<td><?php echo "$data[tanggal_pesan]"; ?></td>
			<td>Rp <?php echo number_format($data['total_bayar']); ?>,-</td>
			<td><?php echo "$data[area_cod]"; ?></td>
			<td>Rp <?php echo number_format($data['biaya_cod']); ?>,-</td>
			<td><?php echo "$data[status_kirim]"; ?></td>
			<td>
				<?php if($data['status_kirim'] == "Pengecekan Pembayaran") : ?>
				<a class="btn btn-sm btn-info" href="index.php?halaman=bayar&username=<?php echo $data['username'] ?>&pesanan=<?php echo $data['no_pemesanan']; ?>">Cek Pembayaran</a>
			<?php endif ?>
			</td>
		</tr>
		<?php
			$no++;
			}
		?>
	</tbody>
</table>