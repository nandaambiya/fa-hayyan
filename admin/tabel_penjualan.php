<?php
	session_start();
	$tanggal = date('d/m/Y');
?>
<!DOCTYPE html>
<html>
<head>
	<title>FA-HAYYAN</title>
</head>
<body>
	<style type="text/css">
	table{
		/*margin: 20px auto;*/
		border-collapse: collapse;
	}
	table th,
	table td{
		border: 1px solid #3c3c3c;
		padding: 3px 8px;
 
	}
	</style>
	<?php
	header("Content-type: application/vnd-ms-excel");
	header("Content-Disposition: attachment; filename=Data Penjualan per ".$tanggal.".xls");
	?>
	<strong><p>Daftar Penjualan FA-HAYYAN per tanggal <?= $tanggal ?></p></strong>
	<table>
		<thead>
		  <tr>
		    <th rowspan="2">Nomor</th>
		    <th rowspan="2">Kode Pesanan</th>
		    <th rowspan="2" width="82px">Tanggal</th>
		    <th rowspan="2">Pengiriman</th>
		    <th colspan="3">Porduk</th>
		  </tr>
		  <tr>
		    <td align="center" width="380px">Nama</td>
		    <td align="center" width="180px">Harga</td>
		    <td align="center">Jumlah</td>
		  </tr>
		</thead>
		<tbody>
		  <?php
		  	include 'koneksi.php';

		  	$i = 1;
		  	$ambil = $koneksi->query("SELECT id_pesanan, tanggal, nama, no_hp, email, alamat, opsi_kirim FROM detail_user_pesanan");

		  	while ($data = $ambil->fetch_assoc()) {
		  ?>
		  <tr>
		    <td><?= $i ?></td>
		    <td><?= $data['id_pesanan'] ?></td>
		    <td><?= $data['tanggal'] ?></td>
		    <td>
		    	Kepada: <?= $data['nama'] ?><br><br>
		    	No. HP: <?= $data['no_hp'] ?><br><br>
		    	Email : <?= $data['email'] ?><br><br>
		    	Alamat: <?= $data['alamat'] ?><br><br>
		    	Kurir : <?= $data['opsi_kirim'] ?>
		    </td>
		    <td>
		    	<?php
		    		$nomor1 = 1;
		    		$ambilnama = $koneksi->query("SELECT nama FROM pesananproduk WHERE id_pesanan = '$data[id_pesanan]'");
		    		while ($datanama = $ambilnama->fetch_assoc()) {
		    			echo $nomor1.") ".$datanama['nama']."<br>";
		    			$nomor1++;
		    		}
		    	?>
		    </td>
		    <td>
		    	<?php
		    		$nomor2 = 1;
		    		$ambilharga = $koneksi->query("SELECT harga FROM pesananproduk WHERE id_pesanan = '$data[id_pesanan]'");
		    		while ($dataharga = $ambilharga->fetch_assoc()) {
		    			echo $nomor2.") @ Rp ".number_format($dataharga['harga']).",-<br>";
		    			$nomor2++;
		    		}
		    	?>
		    </td>
		    <td><?php
		    		$nomor3 = 1;
		    		$ambiljumlah = $koneksi->query("SELECT jumlah_beli FROM pesananproduk WHERE id_pesanan = '$data[id_pesanan]'");
		    		while ($datajumlah = $ambiljumlah->fetch_assoc()) {
		    			echo $nomor3.") ".number_format($datajumlah['jumlah_beli'])."<br>";
		    			$nomor3++;
		    		}
		    	?></td>
		  </tr>
		   <?php
		   		$i++;
			 } 
			?>
		</tbody>
	</table>
</body>
</html>