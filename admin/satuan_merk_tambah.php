<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<h3>Tambah Merk Produk</h3>

<form enctype="multipart/form-data" method="POST">
	<table class="table table-border">
		<tr>
			<td>Merk</td>
			<td><input required class="form-control" type="text" name="satuan_merk" placeholder="Merk..."></td>
		</tr>
	</table>
   <button class="btn btn-success" onclick="return confirm('Simpan data produk?')" name="simpan">Simpan</button>
   <a  href="index.php?halaman=satuan_merk" class="btn btn-info">BACK</span></a>
</form>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<?php
	if (isset($_POST['simpan'])) {
		$koneksi->query("INSERT INTO produk_merk (merk) VALUES ('$_POST[satuan_merk]')");
	
	echo "<script>alert('Data Berhasil Ditambahkan!');</script>";
	echo "<script>location='index.php?halaman=satuan_merk';</script>";
	}
?>