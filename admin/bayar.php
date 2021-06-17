<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<?php
$nopesan = $_GET['id'];

$datapesanan = $koneksi->query("SELECT * FROM pesanan WHERE id_pesanan = '$nopesan'")->fetch_assoc();

$query = $koneksi->query("SELECT * FROM pembayaran WHERE id_pesanan = '$nopesan'");
$data = $query->fetch_assoc();
?>

<h3>Data Pembayaran Order #<?= $nopesan ?></h3>
<form method="POST">
	<table class="table table-borderless">
		<tr>
			<td>No. Pembayaran</td>
			<td>#<?= $data['id_pembayaran'] ?></td>
		</tr>
		<tr>
			<td>Nama Pembayar</td>
			<td><?= $data['nama_pembayar'] ?></td>
		</tr>
		<tr>
			<td>Metode Pembayaran</td>
			<td><?= $data['metode_bayar'] ?></td>
		</tr>
		<tr>
			<td>Tanggal Pembayaran</td>
			<td><?= $data['tanggal'] ?></td>
		</tr>
		<tr>
			<td>Bukti Pembayaran</td>
			<td><img style="width: 300px" src="foto_bukti_bayar/<?= $data['bukti_pembayaran'] ?>"></td>
		<tr>
			<td>Pilih Status</td>
			<td width="74%">
				<select class="form-control" name="stats" required>

					<?php if($datapesanan['status_pesanan'] == "Pembayaran Berhasil"): ?>
					<option value="">--Pilih Status--</option>
					<option value="Pembayaran Berhasil" selected>Pembayaran Berhasil</option>
					<option value="Pembayaran Invalid">Pembayaran Invalid</option>
					<option value="Dibatalkan">Batalkan Pesanan</option>

					<?php else: ?>
					<option value="">--Pilih Status--</option>
					<option value="Pembayaran Berhasil">Pembayaran Berhasil</option>
					<option value="Pembayaran Invalid">Pembayaran Invalid</option>
					<option value="Dibatalkan">Batalkan Pesanan</option>

					<?php endif ?>
				</select>
			</td>	
		</tr>
		<tr>
			<td>Nomor Resi</td>
			<td>
				<input class="form-control" type="text" name="resi" placeholder="Nomor Resi Pengiriman" value="<?= $datapesanan['resi_pengiriman'] ?>">
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
		$koneksi->query("UPDATE pesanan SET status_pesanan = '$_POST[stats]', resi_pengiriman = '$_POST[resi]' WHERE id_pesanan = '$nopesan'");

		echo "<script>alert('Berhasil Diproses!');</script>";
		echo "<script>window.location.href='?halaman=pesanan';</script>";
	}
?>