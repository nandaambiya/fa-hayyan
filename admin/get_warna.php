<?php
	include 'koneksi.php';
	$edisi = $_POST['edisi'];

	echo "<option value=''>Pilih Warna</option>";

	$query = "SELECT id_warna, warna FROM kategori_warna_produk WHERE id_edisi=? ORDER BY warna ASC";
	$dewan1 = $koneksi->prepare($query);
	$dewan1->bind_param("i", $edisi);
	$dewan1->execute();
	$res1 = $dewan1->get_result();
	while ($row = $res1->fetch_assoc()) {
		echo "<option value='" . $row['id_warna'] . "'>" . $row['warna'] . "</option>";
	}
?>