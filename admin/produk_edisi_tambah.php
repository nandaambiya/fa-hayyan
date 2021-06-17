<h3>Tambah Data Edisi</h3>

<br><br>
<form action="produk_edisi_tambah_action.php" name="myForm" enctype="multipart/form-data" method="POST">
	<table class="table table-borderless">
		<tr>
			<td>Nama Edisi</td>
			<td><input required class="form-control" type="text" name="nama" placeholder="Nama Edisi"></td>
		</tr>
		<tr>
			<td>Thumbnail Masker</td>
			<td>
				<br><br>
				Upload foto untuk menambahkan thumbnail masker (Jika edisi memiliki produk masker).
				<input class="form-control" type="file" name="foto_masker" accept="image/*">
				<br><br><br>
			</td>
		</tr>
		<tr>
			<td>Thumbnail Scrunchie</td>
			<td>
				<br><br>
				Upload foto untuk menambahkan thumbnail scrunchie (Jika edisi memiliki produk scrunchie).
				<input class="form-control" type="file" name="foto_scrunchie" accept="image/*">
				<br><br><br>
			</td>
		</tr>
		<tr>
			<td>Warna</td>
			<td>
				Tambahkan variasi warna pada halaman Detail Edisi.
			</td>
		</tr>
	</table>
	<input type="submit" class="btn btn-success" name="simpan" onclick="return validateAndSend();" value="Simpan">
</form>

<script>
        function validateAndSend() {
            if (myForm.foto_masker.value == '' && myForm.foto_scrunchie.value == '') {
                alert('Upload setidaknya satu foto thumbnail.');
                return false;
            }
            else {
                return true;
            }
        }
    </script>