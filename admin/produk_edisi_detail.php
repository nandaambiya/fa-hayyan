<head>
	<link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
</head>
<h3>Detail Edisi</h3>
<?php

	$edisi = $koneksi->query("SELECT * FROM kategori_produk_edisi WHERE id_edisi = '$_GET[id]'")->fetch_assoc();

	$ambilwarna = $koneksi->query("SELECT * FROM kategori_warna_produk WHERE id_edisi = '$edisi[id_edisi]'");
?>

<a href="produk_edisi_hapus.php?id=<?= $_GET['id'] ?>" style="float: right;" onclick="return confirm('Yakin ingin hapus seluruh data edisi ini?')" class="btn btn-sm btn-danger">Hapus Edisi</a>
<br><br><br>
<form enctype="multipart/form-data" method="POST">
	<table class="table table-borderless">
		<tr>
			<td>Nama Edisi</td>
			<td><input required class="form-control" type="text" name="nama" value="<?php echo $edisi['edisi']; ?>"></td>
		</tr>
		<tr>
			<td>Thumbnail Masker</td>
			<td>
				<?php if(!empty($edisi['foto_masker'])) : ?>
					<img width="800" src="../edisi/<?= $edisi['foto_masker'] ?>">

				<?php else : ?>
					<p style="color: red"> Edisi tidak memiliki foto masker </p>

				<?php endif ?>

				<br><br><br>
				Upload foto untuk mengganti atau menambahkan thumbnail
				<input class="form-control" type="file" name="foto_masker" accept="image/*">
				<br><br><br>
			</td>
		</tr>
		<tr>
			<td>Thumbnail Scrunchie</td>
			<td>
				<?php if(!empty($edisi['foto_scrunchie'])) : ?>
					<img width="800" src="../edisi/<?= $edisi['foto_scrunchie'] ?>">

				<?php else : ?>
					<p style="color: red"> Edisi tidak memiliki foto scrunchie </p>

				<?php endif ?>

				<br><br><br>
				Upload foto untuk mengganti atau menambahkan thumbnail
				<input class="form-control" type="file" name="foto_scrunchie" accept="image/*">
				<br><br><br>
			</td>
		</tr>
		<tr>
			<td>Warna</td>
			<td>
				<?php 
					while ($warna = $ambilwarna->fetch_assoc()){
				?>
					<a href="produk_edisi_hapus_warna.php?id=<?= $warna['id_warna'] ?>" class="btn" onclick="return confirm('Yakin ingin menghapus variasi warna ini? Jika warna telah dihapus, warna akan tetap hilang meski tombol \'Simpan\' belum di-klik.')">&times;</a>&emsp;&emsp;<?= $warna['warna'] ?>
					<br>
				<?php } ?>
				<br>
			 <div class="col-lg-3">
			  <div class="input-group">
				<input type="text" name="warna_baru" class="form-control" placeholder="Tambah Warna" style="width: 200px">
				<span class="input-group-btn">
					<input type="submit" name="tambah-warna" onclick="return confirm('Tambah variasi warna? Warna akan tetap tersimpan meski tombol \'Simpan\' belum di-klik')" class="btn btn-default" value="&#43; Tambah"><br>
				</span>
			  </div>
			 </div>
			</td>
		</tr>
	</table>
	<input type="submit" class="btn btn-success" name="simpan" onclick="return confirm('Perbaharui data?')" value="Simpan">
</form>

<?php

if (isset($_POST['simpan'])) {
	$namafoto_m = $_FILES['foto_masker']['name'];
	$lokasisementarafoto_m = $_FILES['foto_masker']['tmp_name'];

	$namafoto_s = $_FILES['foto_scrunchie']['name'];
	$lokasisementarafoto_s = $_FILES['foto_scrunchie']['tmp_name'];

	if (!empty($lokasisementarafoto_m) && empty($lokasisementarafoto_s)) {
		move_uploaded_file($lokasisementarafoto_m, "../edisi/".$namafoto_m);

		$koneksi->query("UPDATE kategori_produk_edisi SET 
			edisi = '$_POST[nama]',
			foto_masker = '$namafoto_m'
			WHERE id_edisi = '$_GET[id]'
			");

		echo "<script>alert('Data Disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk_edisi';</script>";
	}

	elseif (empty($lokasisementarafoto_m) && !empty($lokasisementarafoto_s)) {
		move_uploaded_file($lokasisementarafoto_s, "../edisi/".$namafoto_s);

		$koneksi->query("UPDATE kategori_produk_edisi SET 
			edisi = '$_POST[nama]',
			foto_scrunchie = '$namafoto_s'
			WHERE id_edisi = '$_GET[id]'");

		echo "<script>alert('Data Disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk_edisi';</script>";
	}

	elseif (!empty($lokasisementarafoto_m) && !empty($lokasisementarafoto_s)) {
		move_uploaded_file($lokasisementarafoto_m, "../edisi/".$namafoto_m);
		move_uploaded_file($lokasisementarafoto_s, "../edisi/".$namafoto_s);

		$koneksi->query("UPDATE kategori_produk_edisi SET 
			edisi = '$_POST[nama]',
			foto_masker = '$namafoto_m',
			foto_scrunchie = '$namafoto_s'
			WHERE id_edisi = '$_GET[id]'");

		echo "<script>alert('Data Disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk_edisi';</script>";
	}

	else{
		$koneksi->query("UPDATE kategori_produk_edisi SET edisi = '$_POST[nama]' WHERE id_edisi = '$_GET[id]'");

		echo "<script>alert('Data Disimpan!');</script>";
		echo "<script>location='index.php?halaman=produk_edisi';</script>";
	}
}
elseif (isset($_POST['tambah-warna'])) {
	$koneksi->query("INSERT INTO kategori_warna_produk (id_edisi, warna) VALUES('$_GET[id]', '$_POST[warna_baru]')");

	echo '<meta http-equiv="refresh" content="0.5" >';
}

?>