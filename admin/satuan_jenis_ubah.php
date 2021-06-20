<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<h3>Edit Satuan Jenis Produk</h3>
<?php
	$data = $koneksi->query("SELECT * FROM jenis_produk WHERE id_jenis = '$_GET[id]'")->fetch_assoc();
?>
<form enctype="multipart/form-data" method="POST">
	<table class="table table-borderless">
		<tr>
			<td>Satuan_Jenis</td>
			<td></td>
			<td><input required class="form-control" type="text" name="satuan_jenis" value="<?php echo $data['jenis']; ?>"></td>
		</tr>
	</table>
	<button class="btn btn-success" name="simpan" onclick="return confirm('Perbaharui data?')">Simpan</button>
	<a  href="index.php?halaman=satuan_jenis" class="btn btn-info">BACK</span></a>
</form>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<?php

	if (isset($_POST['simpan'])) {
		$koneksi->query("UPDATE jenis_produk SET
			jenis = '$_POST[satuan_jenis]'
			WHERE id_jenis = '$_GET[id]'
			");

		echo "<script>alert('Data Berhasil Diubah!');</script>";
		echo "<script>location='index.php?halaman=satuan_jenis';</script>";
	}

?>