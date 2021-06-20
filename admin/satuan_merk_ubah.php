<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<h3>Edit Merk Produk</h3>
<?php
	$data = $koneksi->query("SELECT * FROM produk_merk WHERE id_merk = '$_GET[id]'")->fetch_assoc();
?>
<form enctype="multipart/form-data" method="POST">
	<table class="table table-borderless">
		<tr>
			<td>Merk</td>
			<td></td>
			<td><input required class="form-control" type="text" name="satuan_merk" value="<?php echo $data['merk']; ?>"></td>
		</tr>
	</table>
	<button class="btn btn-success" name="simpan" onclick="return confirm('Perbaharui data?')">Simpan</button>
	<a  href="index.php?halaman=satuan_merk" class="btn btn-info">BACK</span></a>
</form>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<?php

	if (isset($_POST['simpan'])) {
		$koneksi->query("UPDATE produk_merk SET
			merk = '$_POST[satuan_merk]'
			WHERE id_merk = '$_GET[id]'
			");

		echo "<script>alert('Data Berhasil Diubah!');</script>";
		echo "<script>location='index.php?halaman=satuan_merk';</script>";
	}

?>