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

    <style type="text/css">
      .btn-kustom {
        color: #fff;
        background-color: #2a351f;
        border-color: #2a351f;
      }

      .btn-kustom:hover {
        color: #fff;
        background-color: #48695a;
        border-color: #48695a;
      }label{
        color: red;
      }
    </style>
</head>
<body>
<?php include "navbar.php";?>
 </div>
  <div style="color: ##2a351f; width: 600px;" class="container">
  <form method="post" class="login_design">
    <br> <br>

    <h2 align="center">Sign Up</h2>
    <h5 align="center">for your FA-HAYYAN account</h3>
    <br>

    <?php
      if (isset($_POST['cekemail'])) {
        $emailregis = $_POST['regisemail'];

        $cekakun = $koneksi->query("SELECT email FROM akun WHERE email = '$emailregis'");
        $adadata = $cekakun->num_rows;

        if ($adadata > 0) {
          echo "<div class='alert alert-danger' role='alert'>Email telah digunakan, silakan gunakan email lain!</div>";
        }
        else{
          echo "<script> window.location.href = 'register_lanjut.php?email=".$emailregis."'; </script>";
        }
      }
    ?>

    <div class="form-group justify-content-center">
      <label for="inputEmail3"><b>Input your email first!</b></label>
      <input type="email" class="form-control" id="inputEmail3" placeholder="Email" name="regisemail" required>
    </div>
    <br>
    <div align="center" class="form-group">
    <button type="submit" name="cekemail" class="btn btn-kustom" style="width: 100%;">Lanjut</button>
    </div> 
  </form>
  </div>

<br>
<br>
<br>

 <?php include "footer.php";?>
</body>
