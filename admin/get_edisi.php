<?php
	include 'koneksi.php';

	echo "<option value=''>Pilih Edisi</option>";

	$query = "SELECT id_edisi, edisi FROM kategori_produk_edisi ORDER BY edisi ASC";
	$dewan1 = $koneksi->prepare($query);
	$dewan1->execute();
	$res1 = $dewan1->get_result();
	while ($row = $res1->fetch_assoc()) {
		echo "<option value='" . $row['id_edisi'] . "'>" . $row['edisi'] . "</option>";
	}
?>