<?php
session_start();
//koneksi ke database
include 'koneksi.php';
?>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <link rel="icon" type="image/*" href="icon/fa_hayyan.png">
  <?php include 'scrsty.php'; ?>
  <title>FA-HAYYAN</title>
</head>

<body>
  <?php include "navbar.php"; ?>

  <!--membuat Carousel -->

  <!-- Section: Block Content -->
  <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img class="d-block w-100" src="carousel/10.png" alt="First slide">
        <!-- <img class="" src="carousel/7.png" alt="First slide" style="margin-left: 650px; "> -->
      </div>
      <div class="carousel-item">
        <img class="d-block w-100" src="carousel/11.png" alt="Second slide">
      </div>
      <div class="carousel-item">
        <img class="d-block w-100" src="carousel/12.png" alt="Third slide">
      </div>
    </div>
    <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  <!-- Carousel Wrapper -->

  </section>
  <!-- Section: Block Content -->

  <!--end of Carousel -->


  <!--index-->

  <div class="container mt-5">

    <style>
      .card-body {
        border-bottom-left-radius: inherit !important;
        border-bottom-right-radius: inherit !important;
      }
    </style>

    <!--Section: Content-->
    <section class="dark-grey-text text-center">
      <h3 class="font-weight-bold mb-4 pb-2">FA-HAYYAN</h3>
      <h5 class="grey-text w-responsive mx-auto mb-5">Fa Hayyan is a pharmacy with complete and best products and will certainly make it easier for you to buy medicine.</h5>
      <br><br>
      <!-- Section heading -->
      <h3 class="font-weight-bold mb-4 pb-2">Special for you</h3>
      <!-- Section description -->


      <div class="row">
        <?php
        $queryambil = $koneksi->query("SELECT id_produk, id_warna, nama_produk, harga_produk, foto_produk, stok_produk FROM produk WHERE stok_produk > 0 ORDER BY rand() LIMIT 6");

        while ($data = $queryambil->fetch_assoc()) {
        ?>
          <div class="col-md-4" style="padding: 40px;">
            <figure class="card card-product">
              <a href="detail.php?id=<?php echo $data['id_produk'] ?>" style="color: inherit; text-decoration: none;">
                <div class="img-wrap"><img src="image/<?= $data['foto_produk'] ?>"></div>
                <figcaption class="info-wrap">
                  <h6 class="title"><?= $data['nama_produk'] ?></h6>
                </figcaption>
              </a>
              <div class="bottom-wrap">

                <div class="price-wrap h5">
                  <span class="price-new">Rp <?= number_format($data['harga_produk']) ?>,-</span>
                </div> <!-- price-wrap.// -->
              </div>
              <div class="bottom-wrap">
                <a href="action_cart_in.php?id=<?php echo $data['id_produk'] ?>" class="btn btn-sm btn-success active float-right">Add To Cart</a> <!-- bottom-wrap.// -->
              </div>

            </figure>
          </div> <!-- col // -->
        <?php } ?>
      </div> <!-- row.// -->

      <br><br>

      <h4>Check all of them out <a href="allstuff.php">here!</a></h4>
    </section>
  </div>
  <!--container.//-->
  <?php include "footer.php"; ?>
</body>

</html>