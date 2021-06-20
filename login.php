<?php
session_start();
//koneksi ke database
include 'koneksi.php';

if (isset($_SESSION['customer']) || !empty($_SESSION['customer'])) {
  header("location:index.php");
}
else if(isset($_SESSION['admin'])){
  header("location:admin/index.php");
}

?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/*" href="icon/fa_hayyan.png">
    <?php include 'scrsty.php'; ?>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>FA-HAYYAN</title>

    <style type="text/css">
      .btn-kustom {
        color: #fff;
        background-color: #5d8975;
        border-color: #5d8975;
      }

      .btn-kustom:hover {
        color: #fff;
        background-color: #2a351f;
        border-color: #2a351f;
      }
      .btn-kustomm {
        color: #fff;
        background-color: #2a351f;
        border-color: #2a351f;
      }

      .btn-kustomm:hover {
        color: #fff;
        background-color: #5d8975;
        border-color: #5d8975;
      }medium{
        color: red;
      }label{
        font-family: roboto-sans;
      }.form-group{
        width: 100%;
      }
    </style>
</head>
<body>
<?php include "navbar.php";?>
<br><br>
<div style="width: 600px; color: #48695a;" class="container">
  <form method="post" class="login_design">
    <center><h2 style="color: #2a351f;">Login</h2></center><br>

    <?php
      if (isset($_POST['tmbllogin'])) {
        $email = $_POST['email'];
        $password = $_POST['pwd'];

        $cekakun = $koneksi->query("SELECT * FROM akun WHERE email = '$email'");
        $hitungakun = $cekakun->num_rows;

        if ($hitungakun == 0) {
          echo "<div class='alert alert-danger' role='alert'>Email atau password salah!</div>";
        }
        else if ($hitungakun == 1) {
          $data = $cekakun->fetch_assoc();

          if ($data['password'] == $password) {

            if ($data['user_db'] == 1) {
              $_SESSION['admin'] = $data;

              echo "<script> alert('Login berhasil!') </script>";
              echo "<script>location='admin/index.php';</script>";
            }

            else if ($data['user_db'] == 2){
              $_SESSION['customer'] = $data;

              echo  '<script type="text/javascript">
                        swal({title: "Login Berhasil!", 
                          text: "", 
                          icon: "success"
                        }).then(function() {
                          window.location = "index.php";
                        });
                     </script>';
            }

            else{
              echo "<div class='alert alert-danger' role='alert'>Email atau password salah!</div>";
            }

          }

          else{
            echo "<div class='alert alert-danger' role='alert'>Email atau password salah!</div>";
          }

        }

      }
    ?>


    <div class="form-group justify-content-center">
      <label for="email">Email<medium>*</medium></label>
      <input type="email" class="form-control" id="email" placeholder="input your email..." name="email" required>
    </div>
    <div class="form-group justify-content-center">
      <label for="pwd">Password<medium>*</medium></label>
      <input type="password" class="form-control" id="pwd" placeholder="input your password..." name="pwd" required>
    </div>
      <!-- <p class="text-center"><a href="forgotpassword.php" class="text-info">Forgot your password?</a></p> -->
      <br>
    <div class="form-group" align="center">
        <button type="submit" name="tmbllogin" class="btn btn-kustomm" style="width: 50%;">Login</button>
        <a href="register.php" class="btn btn-kustom" style="width: 49%;">Create Account</a>
    </div> <!-- form-group// -->          
                                                       
</form>
</article>
</div> <!-- card.// -->
</div>
<br><br>
 <?php include "footer.php";?>
