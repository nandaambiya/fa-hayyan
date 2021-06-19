<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<h3>Tambah Data Produk</h3>

<form enctype="multipart/form-data" method="POST">
	<table class="table table-borderless">
		<tr>
			<td>Nama Produk</td>
			<td></td>
			<td><input required class="form-control" type="text" name="nama" placeholder="Nama Produk"></td>
		</tr>
		<tr>
			<td>Jenis</td>
			<td></td>
			<td>
				<select name="satuan_jenis" id="satuan_jenis" class="form-control" required>
					<option value="">Pilih Jenis</option>
<!-- 					<option value="1">Masker</option>
					<option value="2">Scrunchie - Biasa</option>
					<option value="3">Scrunchie - Zipper</option> -->
				</select>
			</td>
		</tr>
		<tr>
			<td>Satuan Ukuran</td>
			<td></td>
			<td>
				<select name="satuan_ukuran" id="satuan_ukuran" class="form-control" required>
					<option value="">Pilih Satuan Ukuran</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Satuan Barang</td>
			<td></td>
			<td>
				<select name="satuan_barang" id="satuan_barang" class="form-control" required>
					<option value="">Pilih Satuan Barang</option>
				</select>
			</td>
		</tr>

		<tr>
			<td>Harga (Rp)</td>
			<td></td>
			<td><input required class="form-control" type="number" min="1" name="harga" placeholder="Harga dalam Rupiah"></td>
		</tr>
		<tr>
			<td>Stok</td>
			<td></td>
			<td><input required class="form-control" type="number" min="0" name="stok" placeholder="Stok Produk"></td>
		</tr>
		<tr>
			<td>Deskripsi (opsional)</td>
			<td></td>
			<td><textarea class="ckeditor" rows="10" cols="100" class="form-control" name="deskripsi" placeholder="Deskripsi lengkap produk"></textarea></td>
		</tr>
		<tr>
			<td>Foto</td>
			<td></td>
			<td><input class="form-control" type="file" name="foto" accept="image/*" required></td>
		</tr>
	</table>
   <button class="btn btn-success" onclick="return confirm('Simpan data produk?')" name="simpan">Simpan</button>
</form>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
		$(document).ready(function(){
          	$.ajax({
                type: 'POST',
              	url: "get_edisi.php",
              	cache: false, 
              	success: function(msg){
                  $("#edisi").html(msg);
                }
            });

          	$("#edisi").change(function(){
          	var edisi = $("#edisi").val();
	          	$.ajax({
	          		type: 'POST',
	              	url: "get_warna.php",
	              	data: {edisi: edisi},
	              	cache: false,
	              	success: function(msg){
	                  $("#warna").html(msg);
	                }
	            });
            });
         });
	</script>

<?php

if (isset($_POST['simpan'])) {
	$namafotobarang = $_FILES['foto']['name'];
	$lokasisementarafoto = $_FILES['foto']['tmp_name'];
	move_uploaded_file($lokasisementarafoto, "../image/".$namafotobarang);

		$koneksi->query("INSERT INTO produk(
			id_jenis,
			id_warna,
			nama_produk,
			harga_produk,
			foto_produk,
			deskripsi_produk,
			stok_produk)
			VALUES(
			'$_POST[jenis]',
			'$_POST[warna]',
			'$_POST[nama]',
			'$_POST[harga]',
			'$namafotobarang',
			'$_POST[deskripsi]',
			'$_POST[stok]')");

		echo "<script>alert('Data berhasil disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk';</script>";
}

?>