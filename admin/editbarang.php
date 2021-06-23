<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<h3>Edit Data Produk</h3>
<?php
	$id_produk = $_GET['id'];

	$data = $koneksi->query("SELECT * FROM produk WHERE id_produk = '$id_produk'")->fetch_assoc();
?>
<form enctype="multipart/form-data" method="POST">
	<table class="table table-borderless">
		<tr>
			<td>Nama Produk</td>
			<td></td>
			<td><input required class="form-control" type="text" name="nama" value="<?php echo $data['nama']; ?>"></td>
		</tr>
		<tr>
			<td>Merk</td>
			<td></td>
			<td>
				<select name="merk" id="merk" class="form-control" required>
					<?php 
						$ambilmerk = $koneksi->query("SELECT * FROM produk_merk");
						while ($datamerk = $ambilmerk->fetch_assoc()) {
							if ($datamerk['id_merk'] == $data['id_merk']) {
					?>
								<option value="<?= $datamerk['id_merk'] ?>" selected><?= $datamerk['merk'] ?></option>
					<?php
							} else {
					?>
								<option value="<?= $datamerk['id_merk'] ?>"><?= $datamerk['merk'] ?></option>
					<?php
							}
						}
					?>
				</select>
			</td>
		</tr>
		<tr>
			<td>Ukuran</td>
			<td></td>
			<td><input required class="form-control" type="number" min="1" name="ukuran" value="<?php echo $data['ukuran']; ?>"></td>
		</tr>
		<tr>
			<td>Satuan Ukuran</td>
			<td></td>
			<td>
				<select name="satuan_ukuran" id="satuan_ukuran" class="form-control" required>
					<?php 
						$ambilukuran = $koneksi->query("SELECT * FROM produk_satuan_ukuran");
						while ($dataukuran = $ambilukuran->fetch_assoc()) {
							if ($dataukuran['id_satuan_ukuran'] == $data['satuan_ukuran']) {
					?>
								<option value="<?= $dataukuran['id_satuan_ukuran'] ?>" selected><?= $dataukuran['satuan'] ?></option>
					<?php
							} else {
					?>
								<option value="<?= $dataukuran['id_satuan_ukuran'] ?>"><?= $dataukuran['satuan'] ?></option>
					<?php
							}
						}
					?>
				</select>
			</td>
		</tr>
		<tr>
			<td>Jenis</td>
			<td></td>
			<td>
				<a class="btn btn-info btn-sm" href="index.php?halaman=jenisbarang&id_produk=<?= $id_produk ?>">Tambah Jenis</a>
				<br>
				<?php
					$ambiljenis = $koneksi->query("SELECT id_produk_jenis, id_jenis FROM produk_jenis WHERE id_produk = '$id_produk'");
					while ($datajenis = $ambiljenis->fetch_assoc()) {
						$namajenis = $koneksi->query("SELECT * FROM jenis_produk WHERE id_jenis = '$datajenis[id_jenis]'")->fetch_assoc();
				?>
					<a href="edit_barang_hapus_jenis.php?id=<?= $datajenis['id_produk_jenis'] ?>" onclick="return confirm('Hapus jenis?')">
						&times;
					</a>
					&nbsp;&nbsp;&nbsp;<?= $namajenis['jenis']; ?><br>
				<?php
					}
				?>
			</td>
		</tr>
		<tr>
			<td>Satuan Jual Barang</td>
			<td></td>
			<td>
				<select name="satuan_barang" id="satuan_barang" class="form-control" required>
					<?php 
						$ambilsatuan = $koneksi->query("SELECT * FROM produk_satuan_barang");
						while ($datasatuan = $ambilsatuan->fetch_assoc()) {
							if ($datasatuan['id_satuan_barang'] == $data['satuan_barang']) {
					?>
								<option value="<?= $datasatuan['id_satuan_barang'] ?>" selected><?= $datasatuan['satuan'] ?></option>
					<?php
							} else {
					?>
								<option value="<?= $datasatuan['id_satuan_barang'] ?>"><?= $datasatuan['satuan'] ?></option>
					<?php
							}
						}
					?>
				</select>
			</td>
		</tr>
		<tr>
			<td>Harga (Rp)</td>
			<td></td>
			<td><input required class="form-control" type="number" min="1" name="harga" value="<?php echo $data['harga']; ?>"></td>
		</tr>
		<tr>
		<tr>
			<td>
				Tambah Stok
				<br>
				<small>Stok lama akan ditambah</small>
			</td>
			<td></td>
			<td><input placeholder="Tambah Stok" class="form-control" type="number" min="1" name="stok"></td>
		</tr>
		<tr>
			<td>Deskripsi</td>
			<td></td>
			<td><textarea rows="15" cols="100" class="ckeditor" required class="form-control" name="deskripsi"><?php echo $data['deskripsi']; ?></textarea></td>
		</tr>
		<tr>
			<td>Foto</td>
			<td width="125px"><img width="125px" src="../image/<?php echo($data['gambar']); ?>"></td>
			<td><input class="form-control" type="file" name="foto" accept="image/*"></td>
		</tr>
	</table>
	<button class="btn btn-success" name="simpan" onclick="return confirm('Perbaharui data?')">Simpan</button>
</form>

<?php

if (isset($_POST['simpan'])) {
	$namafotobarang = date('dmYHis')."_produk_".$_FILES['foto']['name'];
	$lokasisementarafoto = $_FILES['foto']['tmp_name'];

	$nama = $_POST['nama'];
	$merk = $_POST['merk'];
	$ukuran = $_POST['ukuran'];
	$satuan_ukuran = $_POST['satuan_ukuran'];
	$satuan_barang = $_POST['satuan_barang'];
	$harga = $_POST['harga'];
	$deskripsi = $_POST['deskripsi'];

	$koneksi->begin_transaction();
	try {

		if (!empty($lokasisementarafoto)) {
			move_uploaded_file($lokasisementarafoto, "../image/".$namafotobarang);

			$koneksi->query("UPDATE produk SET 
				nama = '$nama',
				id_merk = '$merk',
				harga = '$harga',
				ukuran = '$ukuran',
				satuan_ukuran = '$satuan_ukuran',
				satuan_barang = '$satuan_barang',
				deskripsi = '$deskripsi',
				gambar = '$namafotobarang'
				WHERE id_produk = '$id_produk'
				");
		} else {
			$koneksi->query("UPDATE produk SET 
				nama = '$nama',
				id_merk = '$merk',
				harga = '$harga',
				ukuran = '$ukuran',
				satuan_ukuran = '$satuan_ukuran',
				satuan_barang = '$satuan_barang',
				deskripsi = '$deskripsi'
				WHERE id_produk = '$id_produk'
				");
		}

		if (!empty($_POST['stok'])) {
			$stok = $_POST['stok'];
			$koneksi->query("UPDATE produk_stok SET stok=stok+$stok WHERE id_produk = '$id_produk'");
		}

		$koneksi->commit();

		echo "<script>alert('Data Disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk';</script>";
	} catch (mysqli_sql_exception $e) {
		$koneksi->rollback();
		echo "<script>alert('Data Gagal disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk';</script>";
	}
}

?>