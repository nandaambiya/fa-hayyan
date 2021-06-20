<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<?php
$id_pesanan = $_GET['id'];

$data = $koneksi->query("SELECT * FROM pembayaran_pesanan WHERE id_pesanan = '$id_pesanan'")->fetch_assoc();
?>

<h3>Data Pembayaran Order #<?= $id_pesanan ?></h3>
<form method="POST">
	<table class="table table-borderless">
		<tr>
			<td>No. Pembayaran</td>
			<td>#<?= $data['id_pembayaran'] ?></td>
		</tr>
		<tr>
			<td>Nama Pembayar</td>
			<td><?= $data['pembayar'] ?></td>
		</tr>
		<tr>
			<td>Metode Pembayaran</td>
			<td><?= $data['metode'] ?></td>
		</tr>
		<tr>
			<td>Tanggal Pembayaran</td>
			<td><?= $data['tanggal'] ?></td>
		</tr>
		<tr>
			<td>Bukti Pembayaran</td>
			<td><img style="width: 800px" src="foto_bukti_bayar/<?= $data['bukti'] ?>"></td>
		<tr>
			<td>Pilih Status</td>
			<td width="74%">
				<select class="form-control" name="stats" required>
					<option value="">--Pilih Status--</option>
					<option value="Dikirim">Dikirim</option>
					<option value="Pembayaran Invalid">Pembayaran Invalid</option>
					<option value="Dibatalkan">Batalkan Pesanan</option>
				</select>
			</td>	
		</tr>
		<tr>
			<td>Nomor Resi</td>
			<td>
				<input class="form-control" type="text" name="resi" placeholder="Nomor Resi Pengiriman" value="<?= $data['resi_pengiriman'] ?>">
				<br>
				Harap masukkan nomor resi setelah Anda memproses pesanan menjadi 'Pembayaran Berhasil' dan telah mengirimkan barang kepada kurir yang dituju!
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<button class="btn btn-info" name="proses" type="submit">Proses</button>
			</td>
		</tr>
	</table>
</form>

<?php
	if (isset($_POST['proses'])) {
		$status = $_POST['stats'];
		$resi = $_POST['resi'];

		$koneksi->query("UPDATE pesanan SET status = '$status', resi_pengiriman = '$resi' WHERE id_pesanan = '$id_pesanan'");

		echo "<script>alert('Berhasil Diproses!');</script>";
		echo "<script>window.location.href='?halaman=pesanan';</script>";
	}
?>