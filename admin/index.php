<?php 

include 'koneksi.php';

session_start();

if (!isset($_SESSION['admin'])) {
    echo "<script>alert('Silakan login terlebih dahulu!');</script>";
    echo "<script>location='../index.php';</script>";
   exit();
}

?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="utf-8" />
      <link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Laman Admin</title>
   
	<!-- BOOTSTRAP STYLES-->
    <link rel="stylesheet" type="text/css" media="screen" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="https://cdn.datatables.net/1.10.22/css/dataTables.bootstrap.min.css">
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FONTAWESOME STYLES-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
     <!-- MORRIS CHART STYLES-->
    <link href="assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
        <!-- CUSTOM STYLES-->
    <link href="assets/css/custom.css" rel="stylesheet" />

     <!-- GOOGLE FONTS-->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

  
</head>
<body>
    <div id="wrapper">
        <nav class="navbar navbar-default navbar-cls-top " role="navigation" style="margin-bottom: 0; background: #2a351f;">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse" >
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" style="background: #2a351f;" href="index.php">
                <img src="../icon/logo_obat1.png" height="30"> </a>
            </div>
  <div style="color: black;
padding: 15px 50px 5px 50px;
float: right;
font-size: 16px; font-family: roboto-sans;"><a href="index.php?halaman=logout" class="btn btn-danger square-btn-adjust" onclick="return confirm('Yakin ingin logout?')">Logout</a> </div>
        </nav>   
           <!-- /. NAV TOP  -->
                <nav class="navbar-default navbar-side" role="navigation" style="background: #fff1b5">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
                    <li><a href="index.php">Home</a></li>
                    <li><a href="index.php?halaman=produk">Produk</a></li>
                    <li><a href="index.php?halaman=produk_edisi">&nbsp;&nbsp;↳ Daftar Edisi - Produk</a></li>
                    <li><a href="index.php?halaman=pesanan">Pesanan</a></li>
                    <li><a href="index.php?halaman=user">Akun Customer</a></li>
                    <li><a href="index.php?halaman=satuan_ukuran">Satuan Ukuran</a></li>
                    <li><a href="index.php?halaman=satuan_barang">Satuan Barang</a></li>
                    <li><a href="index.php?halaman=satuan_jenis">Satuan Jenis</a></li>
                </ul>
               
            </div>
            
        </nav>  
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper" >
            <div id="page-inner">
                <div class="row">
                    <div class="col-md-12">
                     <h2>Admin</h2>   
                        <h5>Hallo <?php echo $_SESSION['admin']['nama']; ?></h5>
                    </div>
                </div>              
                 <!-- /. ROW  -->
                  <hr />
                <?php
                if (isset($_GET['halaman']))
                {
                    if ($_GET['halaman']=="produk"){
                        include 'produk.php';
                    }
                    elseif ($_GET['halaman']=="produk_edisi"){
                        include 'produk_edisi.php';
                    }
                    elseif ($_GET['halaman']=="produk_edisi_tambah"){
                        include 'produk_edisi_tambah.php';
                    }
                    elseif ($_GET['halaman']=="detail_edisi"){
                        include 'produk_edisi_detail.php';
                    }
                    elseif ($_GET['halaman']=="pesanan"){
                        include 'orderan.php';
                    }
                    elseif ($_GET['halaman']=="user")
                    {
                        include 'user.php';
                    }
                    elseif ($_GET['halaman']=="detail")
                    {
                        include 'detail.php';
                    }
                    elseif ($_GET['halaman']=="inputbarang")
                    {
                        include 'inputbarang.php';
                    }
                     elseif ($_GET['halaman']=="editbarang")
                    {
                        include 'editbarang.php';
                    }
                    elseif ($_GET['halaman']=="hapususer")
                    {
                        include 'hapususer.php';
                    }   
                    elseif ($_GET['halaman']=="logout")
                    {
                        echo "<script>location='logout.php';</script>";
                    }
                    elseif ($_GET['halaman']=="bayar") 
                    {
                        include 'bayar.php';
                    }
                    elseif ($_GET['halaman']=="riwayat"){
                        include 'riwayat.php';
                    }
                     elseif ($_GET['halaman']=="satuan_ukuran"){
                        include 'satuan_ukuran.php';
                    }
                     elseif ($_GET['halaman']=="satuan_ukuran_tambah"){
                        include 'satuan_ukuran_tambah.php';
                    }
                      elseif ($_GET['halaman']=="satuan_ukuran_ubah"){
                        include 'satuan_ukuran_ubah.php';
                    }
                      elseif ($_GET['halaman']=="satuan_ukuran_hapus"){
                        include 'satuan_ukuran_hapus.php';
                    }
                      elseif ($_GET['halaman']=="satuan_barang"){
                        include 'satuan_barang.php';
                    }
                      elseif ($_GET['halaman']=="satuan_barang_tambah"){
                        include 'satuan_barang_tambah.php';
                    }
                      elseif ($_GET['halaman']=="satuan_barang_ubah"){
                        include 'satuan_barang_ubah.php';
                    }
                      elseif ($_GET['halaman']=="satuan_barang_hapus"){
                        include 'satuan_barang_hapus.php';
                    }
                    elseif ($_GET['halaman']=="satuan_jenis"){
                        include 'satuan_jenis.php';
                    }
                     elseif ($_GET['halaman']=="satuan_jenis_tambah"){
                        include 'satuan_jenis_tambah.php';
                    }
                      elseif ($_GET['halaman']=="satuan_jenis_ubah"){
                        include 'satuan_jenis_ubah.php';
                    }
                      elseif ($_GET['halaman']=="satuan_jenis_hapus"){
                        include 'satuan_jenis_hapus.php';
                    }
                }
                else{
                    include 'home.php';
                }
                ?>
                 <!-- /. ROW  -->           
             </div>
             <!-- /. PAGE INNER  -->
            </div>
         <!-- /. PAGE WRAPPER  -->
        </div>
     <!-- /. WRAPPER  -->
    <!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
    <!-- JQUERY SCRIPTS -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>

    <script src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.22/js/dataTables.bootstrap.min.js"></script>
	<script src="ckeditor/ckeditor.js"></script>
    <!-- BOOTSTRAP SCRIPTS -->
    <!-- <script src="assets/js/bootstrap.min.js"></script> -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- METISMENU SCRIPTS -->
    <script src="assets/js/jquery.metisMenu.js"></script>
     <!-- MORRIS CHART SCRIPTS -->
     <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="assets/js/morris/morris.js"></script>
      <!-- CUSTOM SCRIPTS -->
    <script src="assets/js/custom.js"></script>
    

</body>
</html>
