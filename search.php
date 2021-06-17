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

<br><br>

<div class="container" align="center">

  <div class="dropdown">
    <button style="color: #48695a;" class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      <?php if(isset($_GET['sortBy'])){echo "Sort by $_GET[sortBy]";} else{ echo "Sort by ...";} ?>
    </button>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
      <a style="color: #48695a" class="dropdown-item" href="?keyword=<?php echo $cari ?>&sortBy=Nama, A - Z">Nama, A - Z</a>
      <a style="color: #48695a" class="dropdown-item" href="?keyword=<?php echo $cari ?>&sortBy=Nama, Z - A">Nama, Z - A</a>
      <a style="color: #48695a" class="dropdown-item" href="?keyword=<?php echo $cari ?>&sortBy=Harga, rendah - tinggi">Harga, rendah - tinggi</a>
      <a style="color: #48695a" class="dropdown-item" href="?keyword=<?php echo $cari ?>&sortBy=Harga, tinggi - rendah">Harga, tinggi - rendah</a>
      <a style="color: #48695a" class="dropdown-item" href="?keyword=<?php echo $cari ?>&sortBy=Date, baru - lama">Date, baru - lama</a>
      <a style="color: #48695a" class="dropdown-item" href="?keyword=<?php echo $cari ?>&sortBy=Date, lama - baru">Date, lama - baru</a>
      <a style="color: #48695a" class="dropdown-item" href="?keyword=<?php echo $cari ?>&sortBy=Masker - Scrunchie">Masker - Scrunchie</a>
      <a style="color: #48695a" class="dropdown-item" href="?keyword=<?php echo $cari ?>&sortBy=Scrunchie - Masker">Scrunchie - Masker</a>
    </div>
  </div>
</div>
  
<br>

<h3 align="center">Hasil pencarian untuk <?php echo $cari; ?></h3>

<div class="container mt-5">

<div class="row justify-content-center">
  <?php

        $batas = 6;
        $halaman = isset($_GET['halaman'])?(int)$_GET['halaman'] : 1;
        $halaman_awal = ($halaman>1) ? ($halaman * $batas) - $batas : 0;  
 
        $previous = $halaman - 1;
        $next = $halaman + 1;
        
        $data = mysqli_query($koneksi,"SELECT * from produk WHERE nama_produk LIKE '%$cari%' OR harga_produk LIKE '%$cari%' AND stok_produk > 0");
        $jumlah_data = mysqli_num_rows($data);
        $total_halaman = ceil($jumlah_data / $batas);

        if($halaman > $total_halaman && $total_halaman != 0){
          echo "<script>alert('Halaman yang dicari tidak ditemukan!');</script>";
          echo "<script>window.history.back();</script>";
        }
    
    $take = $koneksi->query("SELECT id_produk, id_warna, nama_produk, harga_produk, foto_produk, stok_produk FROM produk WHERE nama_produk LIKE '%$cari%' OR harga_produk LIKE '%$cari%' AND stok_produk > 0 ORDER BY nama_produk LIMIT $halaman_awal, $batas");

    if(isset($_GET['sortBy'])){
      $sort = $_GET['sortBy'];

      if($sort == "Nama, A - Z"){
        $take = $koneksi->query("SELECT id_produk, id_warna, nama_produk, harga_produk, foto_produk, stok_produk FROM produk WHERE nama_produk LIKE '%$cari%' OR harga_produk LIKE '%$cari%' AND stok_produk > 0 ORDER BY nama_produk ASC LIMIT $halaman_awal, $batas");
      }

      else if ($sort == "Nama, Z - A"){
        $take = $koneksi->query("SELECT id_produk, id_warna, nama_produk, harga_produk, foto_produk, stok_produk FROM produk WHERE nama_produk LIKE '%$cari%' OR harga_produk LIKE '%$cari%' AND stok_produk > 0 ORDER BY nama_produk DESC LIMIT $halaman_awal, $batas");
      }

      else if ($sort == "Harga, rendah - tinggi"){
        $take = $koneksi->query("SELECT id_produk, id_warna, nama_produk, harga_produk, foto_produk, stok_produk FROM produk WHERE nama_produk LIKE '%$cari%' OR harga_produk LIKE '%$cari%' AND stok_produk > 0 ORDER BY harga_produk ASC LIMIT $halaman_awal, $batas");
      }

      else if ($sort == "Harga, tinggi - rendah"){
        $take = $koneksi->query("SELECT id_produk, id_warna, nama_produk, harga_produk, foto_produk, stok_produk FROM produk WHERE nama_produk LIKE '%$cari%' OR harga_produk LIKE '%$cari%' AND stok_produk > 0 ORDER BY harga_produk DESC LIMIT $halaman_awal, $batas");
      }

      else if ($sort == "Date, baru - lama"){
        $take = $koneksi->query("SELECT id_produk, id_warna, nama_produk, harga_produk, foto_produk, stok_produk FROM produk WHERE nama_produk LIKE '%$cari%' OR harga_produk LIKE '%$cari%' AND stok_produk > 0 ORDER BY id_produk DESC LIMIT $halaman_awal, $batas");
      }

      else if ($sort == "Date, lama - baru"){
        $take = $koneksi->query("SELECT id_produk, id_warna, nama_produk, harga_produk, foto_produk, stok_produk FROM produk WHERE nama_produk LIKE '%$cari%' OR harga_produk LIKE '%$cari%' AND stok_produk > 0 ORDER BY id_produk ASC LIMIT $halaman_awal, $batas");
      }

      else if ($sort == "Masker - Scrunchie"){
        $take = $koneksi->query("SELECT id_produk, id_warna, nama_produk, harga_produk, foto_produk, stok_produk FROM produk WHERE nama_produk LIKE '%$cari%' OR harga_produk LIKE '%$cari%' AND stok_produk > 0 ORDER BY id_jenis ASC LIMIT $halaman_awal, $batas");
      }

      else if ($sort == "Scrunchie - Masker"){
        $take = $koneksi->query("SELECT id_produk, id_warna, nama_produk, harga_produk, foto_produk, stok_produk FROM produk WHERE nama_produk LIKE '%$cari%' OR harga_produk LIKE '%$cari%' AND stok_produk > 0 ORDER BY id_jenis DESC LIMIT $halaman_awal, $batas");
      }
    }

    if (mysqli_num_rows($take) == 0) {
      echo "<h3 align='center'>Tidak ada hasil ...</h3>";
    }

    while ($data = $take->fetch_assoc()){
  ?>
  <div class="col-md-4"> <!-- column -->
    <!-- script -->
      
  	<a href="detail.php?id=<?php echo $data['id_produk'] ?>" style="color: inherit; text-decoration: none;">
    <figure class="card card-product"> 
      <div class="img-wrap"><img src="image/<?php echo $data['foto_produk'] ?>"></div>
      <figcaption class="info-wrap">
          <h4 class="title"><?php echo $data['nama_produk']; ?></h4>
          <p class="desc">Stok : <?php echo number_format($data['stok_produk']); ?></p>
          <!-- <div class="rating-wrap">	
            <div class="label-rating">132 reviews</div>
            <div class="label-rating">154 orders </div>
          </div> //.rating-wrap.// -->
      </figcaption>
      <div class="bottom-wrap">
        <a href="action_cart_in.php?id=<?php echo $data['id_produk'] ?>" class="btn btn-sm btn-danger active float-right">Add To Cart</a> 
        <div class="price-wrap h5 float-left">
          <span class="price-new">Rp <?php echo number_format($data['harga_produk']); ?></span>
        </div> <!-- price-wrap.// -->
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
          <a class="page-link" <?php if($halaman > 1 && isset($_GET['sortBy'])){ echo "href='?keyword=$cari&sortBy=$_GET[sortBy]&halaman=$previous'"; } else if($halaman > 1){echo "href='?keyword=$cari&halaman=$previous'";} ?>>Previous</a>
        </li>
        <?php
        if (isset($_GET['sortBy'])) {
          $sort = $_GET['sortBy'];

          for($x=1;$x<=$total_halaman;$x++){
          ?>
          <li class="page-item"><a class="page-link" href="?keyword=<?php echo $cari ?>&sortBy=<?php echo $sort ?>&halaman=<?php echo $x ?>"><?php echo $x; ?></a></li>
          <?php
          }
        }
        else{
          for($x=1;$x<=$total_halaman;$x++){
          ?>
          <li class="page-item"><a class="page-link" href="?keyword=<?php echo $cari ?>&halaman=<?php echo $x ?>"><?php echo $x; ?></a></li>
          <?php
          }
        }
        ?>
        <li class="page-item">
          <a  class="page-link" <?php if($halaman < $total_halaman && isset($_GET['sortBy'])){echo "href='?keyword=$cari&sortBy=$_GET[sortBy]&halaman=$next'";} else if($halaman < $total_halaman) { echo "href='?keyword=$cari&halaman=$next'"; } ?>>Next</a>
        </li>
      </ul>
    </nav>

</div> 
<!--container.//-->
<br><br>
<?php include 'footer.php'; ?>

</body>
</html>