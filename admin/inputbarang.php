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
			<td>Merk</td>
			<td></td>
			<td>
				<select name="merk" id="merk" class="form-control" required>
					<option value="">-- Pilih Merk --</option>
					<?php
						$ambilmerk = $koneksi->query("SELECT * FROM produk_merk");

						while ($datamerk = $ambilmerk->fetch_assoc()) {
					?>	
						<option value="<?php echo $datamerk['id_merk']; ?>"><?php echo $datamerk['merk']; ?></option>
					<?php
						}
					?>
				</select>
			</td>
		</tr>
		<tr>
			<td>Ukuran</td>
			<td></td>
			<td><input required class="form-control" type="number" min="1" name="ukuran" placeholder="Ukuran Barang"></td>
		</tr>
		<tr>
			<td>Satuan Ukuran</td>
			<td></td>
			<td>
				<select name="satuan_ukuran" id="satuan_ukuran" class="form-control" required>
					<option value="">-- Pilih Satuan Ukuran --</option>
					<?php
						$ambilukuran = $koneksi->query("SELECT * FROM produk_satuan_ukuran");

						while ($dataukuran = $ambilukuran->fetch_assoc()) {
					?>	
						<option value="<?php echo $dataukuran['id_satuan_ukuran']; ?>"><?php echo $dataukuran['satuan']; ?></option>
					<?php
						}
					?>
				</select>
			</td>
		</tr>
		<tr>
			<td>Satuan Jual Barang</td>
			<td></td>
			<td>
				<select name="satuan_barang" id="satuan_barang" class="form-control" required>
					<option value="">-- Pilih Satuan Jual --</option>
					<?php
						$ambilsatuan = $koneksi->query("SELECT * FROM produk_satuan_barang");

						while ($datasatuan = $ambilsatuan->fetch_assoc()) {
					?>	
						<option value="<?php echo $datasatuan['id_satuan_barang']; ?>"><?php echo $datasatuan['satuan']; ?></option>
					<?php
						}
					?>
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
			<td>Deskripsi</td>
			<td></td>
			<td><textarea required class="ckeditor" rows="10" cols="100" class="form-control" name="deskripsi" placeholder="Deskripsi lengkap produk"></textarea></td>
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
<?php

if (isset($_POST['simpan'])) {
	$namafotobarang = date('dmYHis')."_produk_".$_FILES['foto']['name'];
	$lokasisementarafoto = $_FILES['foto']['tmp_name'];
	move_uploaded_file($lokasisementarafoto, "../image/".$namafotobarang);

	$nama = $_POST['nama'];
	$merk = $_POST['merk'];
	$ukuran = $_POST['ukuran'];
	$satuan_ukuran = $_POST['satuan_ukuran'];
	$satuan_barang = $_POST['satuan_barang'];
	$harga = $_POST['harga'];
	$stok = $_POST['stok'];
	$deskripsi = $_POST['deskripsi'];

	try {
		$koneksi->begin_transaction();

		$koneksi->query("INSERT INTO produk(
			id_merk,
			nama,
			harga,
			ukuran,
			satuan_ukuran,
			satuan_barang,
			deskripsi,
			gambar)
			VALUES(
			'$merk',
			'$nama',
			'$harga',
			'$ukuran',
			'$satuan_ukuran',
			'$satuan_barang',
			'$deskripsi',
			'$namafotobarang')");

		$id_produk = $koneksi->insert_id;

		$koneksi->query("INSERT INTO produk_stok(id_produk, stok, diubah) VALUES('$id_produk', '$stok', date_format(now(),'%d-%m-%Y %H:%i:%s'))");

		$koneksi->commit();

		echo "<script>alert('Data berhasil disimpan!');</script>";
		echo "<script>location='index.php?halaman=jenisbarang&id_produk=".$id_produk."';</script>";
	} catch (Exception $e) {
		$koneksi->rollback();

		echo "<script>alert('Data gagal disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk';</script>";
	}
}

?>