<?php
session_start();
//koneksi ke database
include 'koneksi.php';
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

  <br><br>

  <?php
    if (isset($_GET['kategori'])) {
      $kategori = $_GET['kategori'];
    } else {
      echo "<script>alert('Halaman yang dicari tidak ditemukan!');</script>";
      echo "<script>window.history.back();</script>";
    }
  ?>

  <div class="container" align="center">

    <div class="dropdown">
      <button style="color: #48695a;" class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <?php if (isset($_GET['sortBy'])) {
          echo "Sort by $_GET[sortBy]";
        } else {
          echo "Sort by ...";
        } ?>
      </button>
      <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
        <a style="color: #48695a" class="dropdown-item" href="?kategori=<?= $kategori ?>&sortBy=Nama, A - Z">Nama, A - Z</a>
        <a style="color: #48695a" class="dropdown-item" href="?kategori=<?= $kategori ?>&sortBy=Nama, Z - A">Nama, Z - A</a>
        <a style="color: #48695a" class="dropdown-item" href="?kategori=<?= $kategori ?>&sortBy=Harga, rendah - tinggi">Harga, rendah - tinggi</a>
        <a style="color: #48695a" class="dropdown-item" href="?kategori=<?= $kategori ?>&sortBy=Harga, tinggi - rendah">Harga, tinggi - rendah</a>
      </div>
    </div>
  </div>

  <div class="container mt-5">

    <div class="row justify-content-center">
      <?php

      $batas = 6;
      $halaman = isset($_GET['halaman']) ? (int)$_GET['halaman'] : 1;
      $halaman_awal = ($halaman > 1) ? ($halaman * $batas) - $batas : 0;

      $previous = $halaman - 1;
      $next = $halaman + 1;

      $data = mysqli_query($koneksi, "SELECT id_produk FROM listproduk WHERE stok > 0 AND jenis = '$kategori' GROUP BY id_produk");
      $jumlah_data = mysqli_num_rows($data);
      $total_halaman = ceil($jumlah_data / $batas);

      if ($halaman > $total_halaman) {
        echo "<script>alert('Halaman yang dicari tidak ditemukan!');</script>";
        echo "<script>window.history.back();</script>";
      }

      $take = $koneksi->query("SELECT id_produk, nama, stok, harga, gambar FROM listproduk WHERE stok > 0 AND jenis = '$kategori' GROUP BY id_produk LIMIT $halaman_awal, $batas");

      if (isset($_GET['sortBy'])) {
        $sort = $_GET['sortBy'];

        if ($sort == "Nama, A - Z") {
          $take = $koneksi->query("SELECT id_produk, nama, stok, harga, gambar FROM listproduk WHERE stok > 0 AND jenis = '$kategori' GROUP BY id_produk ORDER BY nama ASC LIMIT $halaman_awal, $batas");
        } else if ($sort == "Nama, Z - A") {
          $take = $koneksi->query("SELECT id_produk, nama, stok, harga, gambar FROM listproduk WHERE stok > 0 AND jenis = '$kategori' GROUP BY id_produk ORDER BY nama DESC LIMIT $halaman_awal, $batas");
        } else if ($sort == "Harga, rendah - tinggi") {
          $take = $koneksi->query("SELECT id_produk, nama, stok, harga, gambar FROM listproduk WHERE stok > 0 AND jenis = '$kategori' GROUP BY id_produk ORDER BY harga ASC LIMIT $halaman_awal, $batas");
        } else if ($sort == "Harga, tinggi - rendah") {
          $take = $koneksi->query("SELECT id_produk, nama, stok, harga, gambar FROM listproduk WHERE stok > 0 AND jenis = '$kategori' GROUP BY id_produk ORDER BY harga DESC LIMIT $halaman_awal, $batas");
        }
      }

      while ($data = $take->fetch_assoc()) {
      ?>
        <div class="col-md-4" style="padding: 40px;">
          <!-- column -->
          <!-- script -->

          <a href="detail.php?id=<?php echo $data['id_produk'] ?>" style="color: inherit; text-decoration: none;">
            <figure class="card card-product">
              <div class="img-wrap"><img src="image/<?php echo $data['gambar'] ?>"></div>
              <figcaption class="info-wrap">
                <h6 class="title"><?php echo $data['nama']; ?></h6>
                <p class="desc">Stok : <?php echo number_format($data['stok']); ?></p>
                <!-- <div class="rating-wrap">	
            <div class="label-rating">132 reviews</div>
            <div class="label-rating">154 orders </div>
          </div> //.rating-wrap.// -->
              </figcaption>
              <div class="bottom-wrap">
                <div class="price-wrap h5 float-left">
                  <span class="price-new">Rp <?php echo number_format($data['harga']); ?>,00</span>
                </div> <!-- price-wrap.// -->
              </div>
              <div class="bottom-wrap" style="align-self: initial;">
                <a href="action_cart_in.php?id=<?php echo $data['id_produk'] ?>" class="btn btn-sm btn-success active float-left">Add To Cart</a>
              </div> <!-- bottom-wrap.// -->
            </figure>
          </a>
        </div>
      <?php } ?>
    </div>
    <br><br>
    <!-- pagination button -->
    <nav>
      <ul class="pagination justify-content-center">
        <li class="page-item">
          <a class="page-link" <?php if ($halaman > 1 && isset($_GET['sortBy'])) {
                                  echo "href='?kategori=$kategori&sortBy=$_GET[sortBy]&halaman=$previous'";
                                } else if ($halaman > 1) {
                                  echo "href='?kategori=$kategori&halaman=$previous'";
                                } ?>>Previous</a>
        </li>
        <?php
        if (isset($_GET['sortBy'])) {
          $sort = $_GET['sortBy'];

          for ($x = 1; $x <= $total_halaman; $x++) {
        ?>
            <li class="page-item"><a class="page-link" href="?kategori=$kategori&sortBy=<?php echo $sort ?>&halaman=<?php echo $x ?>"><?php echo $x; ?></a></li>
          <?php
          }
        } else {
          for ($x = 1; $x <= $total_halaman; $x++) {
          ?>
            <li class="page-item"><a class="page-link" href="?kategori=$kategori&halaman=<?php echo $x ?>"><?php echo $x; ?></a></li>
        <?php
          }
        }
        ?>
        <li class="page-item">
          <a class="page-link" <?php if ($halaman < $total_halaman && isset($_GET['sortBy'])) {
                                  echo "href='?kategori=$kategori&sortBy=$_GET[sortBy]&halaman=$next'";
                                } else if ($halaman < $total_halaman) {
                                  echo "href='?kategori=$kategori&halaman=$next'";
                                } ?>>Next</a>
        </li>
      </ul>
    </nav>

  </div>
  <!--container.//-->
  <br><br>
  <?php include 'footer.php'; ?>

</body>

</html>