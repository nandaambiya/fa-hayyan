<?php
session_start();
//koneksi ke database
    include 'koneksi.php';

    $cari = $_GET['keyword'];
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
  
<br><br><br>

<h3 align="center">Hasil pencarian untuk '<?php echo $cari; ?>'</h3>

<div class="container mt-5">

<div class="row justify-content-center">
  <?php
    $ambil = mysqli_query($koneksi, "CALL cariProduk('$cari');");
    $jumlah_data = mysqli_num_rows($ambil);

    if ($jumlah_data == 0) {
      echo "<h3 align='center'>Tidak ada hasil ...</h3>";
    }

    while ($data = mysqli_fetch_assoc($ambil)){
  ?>
  <div class="col-md-4"> <!-- column -->
    <!-- script -->
      
  	<a href="detail.php?id=<?php echo $data['id_produk'] ?>" style="color: inherit; text-decoration: none;">
    <figure class="card card-product"> 
      <div class="img-wrap"><img src="image/<?php echo $data['gambar'] ?>"></div>
      <figcaption class="info-wrap">
          <h4 class="title"><?php echo $data['nama']; ?></h4>
          <p class="desc">Stok <?php echo number_format($data['stok']); ?></p>
          <!-- <div class="rating-wrap">	
            <div class="label-rating">132 reviews</div>
            <div class="label-rating">154 orders </div>
          </div> //.rating-wrap.// -->
      </figcaption>
      <div class="bottom-wrap">
        <div class="price-wrap h5 float-left">
          <span class="price-new">Rp <?php echo number_format($data['harga']); ?>,-</span>
        </div> <!-- price-wrap.// -->
      </div> <!-- bottom-wrap.// -->
      <div class="bottom-wrap" style="align-self: initial;">
        <a href="action_cart_in.php?id=<?php echo $data['id_produk'] ?>" class="btn btn-sm btn-success active float-left">Add To Cart</a>
      </div> <!-- bottom-wrap.// -->
    </figure>
    </a>
  </div>
  <?php } ?>
</div>
<br><br>
</div> 
<!--container.//-->
<br><br>
<?php include 'footer.php'; ?>

</body>
</html>