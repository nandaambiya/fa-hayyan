<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<h3>Tambah Satuan Ukuran Produk</h3>

<form enctype="multipart/form-data" method="POST">
	<table class="table table-border">
		<tr>
			<td>Satuan Ukuran</td>
			<td><input required class="form-control" type="text" name="satuan_ukuran" placeholder="Ukuran..."></td>
		</tr>
	</table>
   <button class="btn btn-success" onclick="return confirm('Simpan data produk?')" name="simpan">Simpan</button>
   <a  href="index.php?halaman=satuan_ukuran" class="btn btn-info">BACK</span></a>
</form>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<?php
	if (isset($_POST['simpan'])) {
		$koneksi->query("INSERT INTO produk_satuan_ukuran (satuan) VALUES ('$_POST[satuan_ukuran]')");
	
	echo "<script>alert('Data Berhasil Ditambahkan!');</script>";
	echo "<script>location='index.php?halaman=satuan_ukuran';</script>";
	}
?>