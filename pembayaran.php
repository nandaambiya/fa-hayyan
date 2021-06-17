<?php
	session_start();

	include 'koneksi.php';

if (isset($_SESSION['admin'])) {
  header("location:admin/index.php");
}
elseif (!isset($_SESSION['customer']) OR empty($_SESSION['customer'])) {
  echo "<script>alert('Silakan Login Terlebih Dahulu!')</script>";
  echo "<script>location='login.php';</script>";
}

$datauser = $koneksi->query("SELECT a.id_akun FROM akun a JOIN pesanan p ON a.id_akun = p.id_akun WHERE p.id_pesanan = '$_GET[id]'")->fetch_assoc();

if ($datauser['id_akun'] != $_SESSION['customer']['id_akun']) {
		echo "<script>location='login.php'</script>";
}

$databayar = $koneksi->query("SELECT status_pesanan FROM pesanan WHERE id_pesanan = '$_GET[id]'")->fetch_assoc();

if ($databayar['status_pesanan'] != "Pembayaran Invalid" && $databayar['status_pesanan'] != "Menunggu Pembayaran") {
	echo "<script>alert('Anda telah Mengirimkan Bukti Pembayaran')</script>";
    echo "<script>location='riwayatbelanja.php';</script>";
}

?>

<!DOCTYPE html>
<html>
<head>
	<title>FA-HAYYAN</title>
  <link rel="icon" type="image/*" href="icon/fa_hayyan.png">
	<?php include 'scrsty.php'; ?>
	<style type="text/css">
      .btn-kustom {
        color: #fff;
        background-color: #5d8975;
        border-color: #5d8975;
      }

      .btn-kustom:hover {
        color: #fff;
        background-color: #48695a;
        border-color: #48695a;
      }
    </style>

</head>
<body>

	<?php include 'navbar.php'; ?>

<div style="margin: 15px" align="center">
	  <div class="card" style="width: 73rem; margin: 30px;">
		<div align="left" class="card-body">
			
			<div class="container">
        <h2>Konfirmasi Pembayaran</h2>
        <br>
        <p>
          Kirim Bukti Pembayaran untuk <b><a class="btn btn-sm btn-kustom" href="nota.php?id=<?= $_GET['id'] ?>">Order #<?= $_GET['id'] ?></a></b>
        </p>
        <div class="alert alert-info">Total Tagihan <strong>Rp <?= number_format($_GET['tagihan']) ?>,-</strong></div>
        <form method="post" enctype="multipart/form-data">
          <div class="form-group">
            <label>Dibayarkan oleh</label>
            <input type="text" name="nama" class="form-control" required>
          </div>
          <div class="form-group">
            <label>Metode Pembayaran</label>
            <select class="form-control" name="metode" required>
              <option value="">--Pilih Metode--</option>
              <option value="Bank BNI">Transfer Bank BNI</option>
              <option value="OVO">OVO</option>
              <option value="DANA">DANA</option>
            </select>
          </div>
         <div class="form-group">
           <label>Bukti Pembayaran</label>
           <input type="file" class="form-control" name="bukti" required>
           <p class="text-danger">Foto harus berformat JPG atau JPEG dan ukuran maksimal 5 MB</p>
         </div>
         <button class="btn btn-kustom" name='kirim'>Kirim</button>
        </form>
      </div>

		</div>
	</div>
</div>

	<?php include 'footer.php'; ?>

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.min.css'>

	<?php

		if (isset($_POST['kirim'])) {
			$formatfoto = pathinfo($_FILES['bukti']['name'], PATHINFO_EXTENSION);
      		$ukuranfoto = $_FILES['bukti']['size'];
      		$namabukti = date('dmYHis')."_nopem_".$_GET['id']."_".$_FILES['bukti']['name'];

      		$nama_pembayar = $_POST['nama'];
      		$metode_bayar = $_POST['metode'];
      		$tanggal  =date('d-m-Y');

      		if(($ukuranfoto <= 5000000) && ($formatfoto == "jpg" || $formatfoto == "jpeg")){
      			$querycek = $koneksi->query("SELECT id_pesanan FROM pembayaran WHERE id_pesanan = '$_GET[id]'");
      			$adadata = $querycek->num_rows;

      			if ($adadata == 0) {
      				$koneksi->query("INSERT INTO pembayaran (id_pesanan, nama_pembayar, metode_bayar, tanggal, bukti_pembayaran)
      									VALUES ('$_GET[id]', '$nama_pembayar', '$metode_bayar', '$tanggal', '$namabukti')");
      			}
      			elseif ($adadata > 0) {
      				$koneksi->query("UPDATE pembayaran SET nama_pembayar = '$nama_pembayar', metode_bayar = '$metode_bayar', tanggal = '$tanggal', bukti_pembayaran = '$namabukti' WHERE id_pesanan = '$_GET[id]'");
      			}

      			$lokasibukti = $_FILES['bukti']['tmp_name'];
          		$lokasisimpan = "admin/foto_bukti_bayar/";
          		move_uploaded_file($lokasibukti, $lokasisimpan.$namabukti);

      			$koneksi->query("UPDATE pesanan SET status_pesanan = 'Verifikasi Pembayaran' WHERE id_pesanan = '$_GET[id]'");

      			echo  '<script type="text/javascript">
                        swal({title: "Pembayaran Berhasil!", 
                          text: "Harap menunggu hingga pembayaran diverifikasi.", 
                          icon: "success"
                        }).then(function() {
                          window.location = "nota.php?id='.$_GET['id'].'";
                        });
                     </script>';
      		}
      		else{
      			echo  '<script type="text/javascript">
                        swal({title: "Pembayaran Gagal!", 
                          text: "Harap unggah foto sesuai format!", 
                          icon: "error"
                        }).then(function() {
                          window.location = "?id='.$_GET['id'].'&tagihan='.$_GET['tagihan'].'";
                        });
                     </script>';
      		}
		}
	?>

</body>
</html>