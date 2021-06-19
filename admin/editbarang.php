<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<h3>Edit Data Produk</h3>
<?php
	$data = $koneksi->query("SELECT * FROM produk WHERE id_produk = '$_GET[id]'")->fetch_assoc();

	$warna = $koneksi->query("SELECT * FROM kategori_warna_produk WHERE id_warna = '$data[id_warna]'")->fetch_assoc();
	$_SESSION['warna'] = $warna;

	$edisi = $koneksi->query("SELECT id_edisi, edisi FROM kategori_produk_edisi WHERE id_edisi = '$warna[id_edisi]'")->fetch_assoc();
	$_SESSION['edisi'] = $edisi;
?>
<form enctype="multipart/form-data" method="POST">
	<table class="table table-borderless">
		<tr>
			<td>Nama Produk</td>
			<td></td>
			<td><input required class="form-control" type="text" name="nama" value="<?php echo $data['nama_produk']; ?>"></td>
		</tr>
		<tr>
			<td>Satuan Jenis</td>
			<td></td>
			<td>
				<select name="satuan_jenis" id="satuan_jenis" class="form-control" required>
					<option value="" selected>JENIS</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Satuan Ukuran</td>
			<td></td>
			<td>
				<select name="satuan_ukuran" id="satuan_ukuran" class="form-control" required>
					<option value="" selected>SATUAN UKURAN</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Satuan Barang</td>
			<td></td>
			<td>
				<select name="satuan_barang" id="satuan_barang" class="form-control" required>
					<option value="" selected>SATUAN BARANG</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Harga (Rp)</td>
			<td></td>
			<td><input required class="form-control" type="number" min="1" name="harga" value="<?php echo $data['harga_produk']; ?>"></td>
		</tr>
		<tr>
		<tr>
			<td>Stok</td>
			<td></td>
			<td><input required class="form-control" type="number" min="0" name="stok" value="<?php echo $data['stok_produk']; ?>"></td>
		</tr>
		<tr>
			<td>Deskripsi (opsional)</td>
			<td></td>
			<td><textarea rows="15" cols="100" class="ckeditor" required class="form-control" name="deskripsi"><?php echo $data['deskripsi_produk']; ?></textarea></td>
		</tr>
		<tr>
			<td>Foto</td>
			<td width="125px"><img width="125px" src="../image/<?php echo($data['foto_produk']); ?>"></td>
			<td><input class="form-control" type="file" name="foto" accept="image/*"></td>
		</tr>
	</table>
	<button class="btn btn-success" name="simpan" onclick="return confirm('Perbaharui data?')">Simpan</button>
</form>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
		$(document).ready(function(){
          	$.ajax({
                type: 'POST',
              	url: "get_edisi_edit.php",
              	cache: false, 
              	success: function(msg){
                  $("#edisi").html(msg);
                }
            });

          	$("#edisi").change(function(){
          	var edisi = $("#edisi").val();
	          	$.ajax({
	          		type: 'POST',
	              	url: "get_warna_edit.php",
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

	if (!empty($lokasisementarafoto)) {
		move_uploaded_file($lokasisementarafoto, "../image/".$namafotobarang);

		$koneksi->query("UPDATE produk SET 
			nama_produk = '$_POST[nama]',
			harga_produk = '$_POST[harga]',
			deskripsi_produk = '$_POST[deskripsi]',
			stok_produk = '$_POST[stok]',
			foto_produk = '$namafotobarang',
			id_jenis = '$_POST[jenis]',
			id_warna = '$_POST[warna]'
			WHERE id_produk = '$_GET[id]'
			");

		echo "<script>alert('Data Disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk';</script>";
	}
	else{
		$koneksi->query("UPDATE produk SET 
			nama_produk = '$_POST[nama]',
			harga_produk = '$_POST[harga]',
			deskripsi_produk = '$_POST[deskripsi]',
			stok_produk = '$_POST[stok]',
			id_jenis = '$_POST[jenis]',
			id_warna = '$_POST[warna]'
			WHERE id_produk = '$_GET[id]'
			");

		echo "<script>alert('Data Disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk';</script>";
	}

	unset($_SESSION['warna']);
	unset($_SESSION['edisi']);
}

?>