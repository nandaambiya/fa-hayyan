<?php
	session_start();
	include 'koneksi.php';

	$query = "SELECT id_edisi, edisi FROM kategori_produk_edisi ORDER BY edisi ASC";
	$dewan1 = $koneksi->prepare($query);
	$dewan1->execute();
	$res1 = $dewan1->get_result();
	while ($row = $res1->fetch_assoc()) {
		if ($row['id_edisi'] == $_SESSION['edisi']['id_edisi']){
			echo "<option value='" . $row['id_edisi'] . "' selected>" . $row['edisi'] . "</option>";
		}
		else{
			echo "<option value='" . $row['id_edisi'] . "'>" . $row['edisi'] . "</option>";
		}
	}
?>