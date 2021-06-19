<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<h3>Tambah Satuan Barang Produk</h3>

<form enctype="multipart/form-data" method="POST">
	<table class="table table-border">
		<tr>
			<td>Satuan Barang</td>
			<td><input required class="form-control" type="text" name="satuan_barang" placeholder="Barang..."></td>
		</tr>
	</table>
   <button class="btn btn-success" onclick="return confirm('Simpan data produk?')" name="simpan">Simpan</button>
   <a  href="index.php?halaman=satuan_barang" class="btn btn-info">BACK</span></a>
</form>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
