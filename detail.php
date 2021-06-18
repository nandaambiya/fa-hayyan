<?php
session_start();
//koneksi ke database
include 'koneksi.php';

$id_produk = $_GET['id'];

$cekdata = $koneksi->query("SELECT id_produk FROM listproduk WHERE id_produk = '$id_produk' AND stok > 0")->num_rows;

if ($cekdata == 0){
  echo "<script>alert('Halaman yang dicari tidak ditemukan!');</script>";
  echo "<script>window.history.back();</script>";
}

function tgl_indo($tanggal){
  $bulan = array (
    1 =>   'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  );
  $pecahkan = explode('-', $tanggal);
  
  // variabel pecahkan 0 = tanggal
  // variabel pecahkan 1 = bulan
  // variabel pecahkan 2 = tahun
 
  return $pecahkan[2] . ' ' . $bulan[ (int)$pecahkan[1] ] . ' ' . $pecahkan[0];
}

?>

<!DOCTYPE html>
<html>
<head>
	<title>FA-HAYYAN</title>
  <link rel="icon" type="image/*" href="icon/fa_hayyan.png">
	<meta charset="utf-8">
    <?php include 'scrsty.php'; ?>
</head>
<body>

	<?php include 'navbar.php'; ?>

	<div class="card-visible" style="width: 75%; margin: 50px 100px 0px 100px;">
  		<div class="row no-gutters ">
        <?php
          $query = "SELECT
                      id_produk,
                      nama,
                      harga,
                      stok,
                      terakhir_diubah,
                      satuan_barang,
                      deskripsi,
                      gambar
                    FROM listproduk WHERE id_produk = '$id_produk'";
          $ambil = $koneksi->query($query);

          while($data = $ambil->fetch_assoc()) {
        ?>
    		<div class="col-md-4">
  				<img src="image/<?php echo $data['gambar'] ?>" class="card-img-top" style="border-radius: 30px; margin: 30px 0px 0px 30px" align="center">
  			</div>
  			<div class="col-md-8">
  				<div class="card-body" style="margin-left: 150px; width: 100%;">
    				<h5 class="card-text"><?php echo $data['nama'] ?></h5>
            <h5 class="card-text">Rp <?php echo number_format($data['harga']); ?>,- / <?= $data['satuan_barang'] ?></h5>
            <br>
            <h6 class="card-text">Tersisa <?php echo number_format($data['stok']); ?></h6>
            <h6 class="card-text">Terakhir diperbarui pada <?= tgl_indo(date("Y-m-d", strtotime($data['terakhir_diubah']))) ?></h6>
    				<br><a href="action_cart_in.php?id=<?php echo $data['id_produk'] ?>" class="btn btn-sm btn-success" style="width: 100%">Add To Cart</a>
    				<br><br>
    				<p style="text-align: justify;"><?php echo $data['deskripsi']; ?></p>
            <h6 class="card-text">Kategori</h6>
            <?php
              $jenis = $koneksi->query("SELECT jenis FROM listproduk WHERE id_produk = '$id_produk'");
              $jumlah = $jenis->num_rows;
              $i = 1;
              while ($datajenis = $jenis->fetch_assoc()) {
                echo $datajenis['jenis'];
                if ($i < $jumlah) {
                  echo ", ";
                }
                $i++;
              }
            ?>
  				</div>
  			</div>
        <?php 
            break; 
          }
        ?>
  		</div>
	</div>
  <br>

	<?php include 'footer.php'; ?>

</body>
</html>