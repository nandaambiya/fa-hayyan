<?php
session_start();
//koneksi ke database
include 'koneksi.php';

$cekdata = $koneksi->query("SELECT id_produk FROM produk WHERE id_produk = '$_GET[id]' AND stok_produk > 0")->num_rows;

if ($cekdata == 0){
  echo "<script>alert('Halaman yang dicari tidak ditemukan!');</script>";
  echo "<script>window.history.back();</script>";
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

          $data = $koneksi->query("SELECT * FROM produk WHERE id_produk = '$_GET[id]'")->fetch_assoc();

          if($data['id_jenis'] == '2'){
            $cekzipper = $koneksi->query("SELECT * FROM produk WHERE id_warna = '$data[id_warna]' AND id_jenis = '3' AND stok_produk > 0");
            $adadata = $cekzipper->num_rows;

            if($adadata > 0)
              $data2 = $cekzipper->fetch_assoc();
          }
          else if($data['id_jenis'] == '3'){
            $cekbiasa = $koneksi->query("SELECT * FROM produk WHERE id_warna = '$data[id_warna]' AND id_jenis = '2' AND stok_produk > 0");
            $adadata = $cekbiasa->num_rows;

            if($adadata > 0){
              $data2 = $data;
              $data = $cekbiasa->fetch_assoc();
            }
          }
        ?>
    		<div class="col-md-4">
  				<img src="image/<?php echo $data['foto_produk'] ?>" class="card-img-top" style="border-radius: 30px; margin: 30px 0px 0px 30px" align="center">
  			</div>
  			<div class="col-md-8">
  				<div class="card-body" style="margin-left: 150px; width: 100%;">
    				<h5 class="card-text"><?php echo $data['nama_produk'] ?></h5>

            <?php if(isset($data2)): ?>
    				<h5 class="card-text">Rp <?php echo number_format($data['harga_produk']); ?> (Biasa)</h5>
            <h5 class="card-text">Rp <?php echo number_format($data2['harga_produk']); ?> (Zipper)</h5>
    				<br>
            <h6 class="card-text">Tersisa <?php echo number_format($data['stok_produk']); ?> Buah (Biasa)</h6>
            <h6 class="card-text">Tersisa <?php echo number_format($data2['stok_produk']); ?> Buah (Zipper)</h6>
            <input type="text" name="" placeholder="Terakhir diperbaharui..." required="">
            <form action="action_cart_in.php" method="get">
             <!--  <div class="form-group">
                <select class="form-control" name="id" style="width: 140px;" required>
                  <option value="">-Pilih Variasi-</option>
                  <option value="<?php echo $data['id_produk'] ?>">Biasa</option>
                  <option value="<?php echo $data2['id_produk'] ?>">Zipper</option>
                </select>
              </div> -->
              <!-- <div class="form-group"> -->
                <br><button type="submit" class="btn btn-sm btn-success" style="width: 100%">Add To Cart</button>
              <!-- </div> -->
            </form>

            <?php else: ?>
            <h5 class="card-text">Rp <?php echo number_format($data['harga_produk']); ?></h5>
            <br>
            <h6 class="card-text">Tersisa <?php echo number_format($data['stok_produk']); ?> Buah</h6>
            <input type="text" name="" placeholder="Terakhir diperbaharui..." required=""><br>
    				<br><a href="action_cart_in.php?id=<?php echo $data['id_produk'] ?>" class="btn btn-sm btn-success" style="width: 100%">Add To Cart</a>

            <?php endif ?>

    				<br><br>
    				<p style="text-align: justify;"><?php echo $data['deskripsi_produk']; ?></p>
  				</div>
  			</div>			
  		</div>
	</div>
  <br>

	<?php include 'footer.php'; ?>

</body>
</html>