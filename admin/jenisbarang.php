<?php 
	$id_produk = $_GET['id_produk']; 
?>

<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<h3>Pilih Jenis Produk</h3>(dapat memilih kembali setelah klik tombol 'Pilih')

<br><br>

<form method="POST">
	<table class="table table-borderless">
		<tr>
			<td>Jenis Produk</td>
			<td></td>
			<td>
				<select name="jenis" id="jenis" class="form-control" required>
					<?php
						$ambiljenis = $koneksi->query("SELECT * FROM jenis_produk");

						while ($datajenis = $ambiljenis->fetch_assoc()) {
					?>	
						<option value="<?php echo $datajenis['id_jenis']; ?>"><?php echo $datajenis['jenis']; ?></option>
					<?php
						}
					?>
				</select>
			</td>
		</tr>
	</table>
   <button style="float: right;" class="btn btn-success" onclick="return confirm('Pilih jenis?')" name="simpan">Pilih</button>
   <br><br><br>
   <button class="btn btn-info" name="selesai" onclick="return confirm('Selesai memilih?')">Selesai</button>
</form>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<?php

if (isset($_POST['simpan'])) {
	$id_jenis = $_POST['jenis'];

	$cek = $koneksi->query("SELECT id_produk FROM produk_jenis WHERE id_produk = '$id_produk' AND id_jenis = '$id_jenis'");

	if ($cek->num_rows > 0) {
		echo "<script>alert('Jenis ini telah dipilih pada produk ini!');</script>";
		echo "<script>location='index.php?halaman=jenisbarang&id_produk=".$id_produk."';</script>";
	} else {
		$koneksi->query("INSERT INTO produk_jenis(id_produk, id_jenis) VALUES('$id_produk', '$id_jenis')");

		echo "<script>alert('Jenis dipilih!');</script>";
		echo "<script>location='index.php?halaman=jenisbarang&id_produk=".$id_produk."';</script>";
	}
} elseif (isset($_POST['selesai'])) {
	$cek = $koneksi->query("SELECT id_produk FROM produk_jenis WHERE id_produk = '$id_produk'");

	if ($cek->num_rows < 1) {
		echo "<script>alert('Pilih setidaknya satu jenis terlebih dahulu!');</script>";
		echo "<script>location='index.php?halaman=jenisbarang&id_produk=".$id_produk."';</script>";
	} else {
		echo "<script>location='index.php?halaman=produk';</script>";
	}
}

?>