<?php

session_start();

include 'koneksi.php';

if (isset($_SESSION['admin'])) {
  header("location:admin/index.php");
}
else if (!isset($_SESSION['customer']) OR empty($_SESSION['customer'])) {
  echo "<script>alert('Silakan Login Terlebih Dahulu!')</script>";
  echo "<script>location ='index.php'</script>";
}

?>

<!DOCTYPE html>
<html>
<head>
	<title>FA-HAYYAN</title>
	<link rel="icon" type="image/*" href="icon/fa_hayyan.png">
	<meta charset="utf-8">

    <style type="text/css">
      .btn-kustom {
        color: #48695a !important;
        border-color: #48695a !important;
      }

      .btn-kustom:hover {
        color: #fff !important;
        background-color: #48695a !important;
        border-color: #48695a !important;
      }
  </style>
</head>
<body>

<?php include 'navbar.php'; ?>

<div align="center">

	<br><br>

	<h3>Riwayat Pesanan Saya</h3>

	<br>
	  <div class="card" style="width: 73rem; margin: 30px;">
		<div class="card-body">
			<table id="tabel-data" width="100%" class="table table-hover">
			  <thead>
			    <tr>
			      <th>Nomor Pesanan</th>
			      <th>Tanggal</th>
			      <th>Status Pembayaran</th>
			      <th>Total</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<?php
			  		$id_akun = $_SESSION['customer']['id_akun'];

			  		$queryambil = $koneksi->query("SELECT * FROM listpesanan WHERE id_akun = '$id_akun'");

			  		while ($data = $queryambil->fetch_assoc()) {
			  	?>
			    <tr>
			    	<td><a href="nota.php?id=<?= $data['id_pesanan'] ?>" class="btn btn-kustom">#<?= $data['id_pesanan'] ?></a></td>
			    	<td><?= $data['tanggal'] ?></td>
			    	<td><?= $data['status'] ?></td>
			    	<td>Rp <?= number_format($data['total_bayar']) ?></td>
			    </tr>
				<?php } ?>

			  </tbody>
			</table>
		</div>
	  </div>

</div>

<?php  include 'footer.php'; ?>

	<link rel="stylesheet" href="assets/faicon/css/all.css">
	<link rel="stylesheet" href="assets/navbar.css">
	<link rel="stylesheet" href="assets/index.css">
	<link rel="stylesheet" href="assets/footer.css">
	<link rel="stylesheet" href="assets/css/style.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script>
	<script src="assets/js/popper.js"></script>

    <script>
    $(document).ready(function(){
        $('#tabel-data').DataTable();
    });
	</script>


</body>
</html>