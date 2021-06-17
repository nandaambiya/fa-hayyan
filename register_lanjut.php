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
    <?php include 'scrsty.php'; ?>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    
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
<?php include "navbar.php";?>

  <div style="color: #48695a; width: 600px;" class="container">
    <br> <br>
    <h2 align="center">Sign Up</h2><br>
    <p align="center">Let's complete your profile</p>

    <div id="alert">
      
    </div>

    <form method="post" name="daftarakun">

    <div class="form-group justify-content-center">
      <label for="email">Email</label>
      <input type="email" name="email" id="email" class="form-control" disabled value="<?php echo $_GET['email'] ?>" required>
    </div>

    <div class="form-group justify-content-center">
      <label for="nama">Name</label>
      <input type="text" name="nama" id="nama" class="form-control" placeholder="Full name" required>
    </div>

    <div class="form-group justify-content-center">
      <label for="nope">No. HP</label>
      <input type="text" name="nope" id="nope" onkeypress="return hanyaAngka(event)" class="form-control" placeholder="Phone Number" required>
    </div>

    <div class="form-group">
      <label for="passw">Password</label>
      <input id="passw" type="password" name="password" class="form-control" placeholder="Password" required>
    </div>

    <div class="form-group">
      <label for="password2">Confirmation Password</label>
      <input type="password" name="password2" id="password2" class="form-control" placeholder="Password (again)" required>
    </div>

    <br>

    <div align="center" class="form-group">
      <button type="submit" name="sendData" class="btn btn-kustom">Register</button>
    </div> 
    </form>
  </div>

<br>
<br>
<br>

<?php

    if (isset($_POST['sendData'])) {
      $email = $_GET['email'];
      $nama = $_POST['nama'];
      $nope = $_POST['nope'];
      $password = $_POST['password'];

      $cek = $koneksi->query("SELECT id_akun FROM akun WHERE email = '$email'");
      $hitungakun = $cek->num_rows;

      if ($hitungakun > 0) {
        echo  '<script type="text/javascript">
                        swal({title: "Registrasi Gagal!", 
                          text: "Email telah digunakan.", 
                          icon: "error"
                        }).then(function() {
                          window.location = "register.php";
                        });
                     </script>';
      }
      else{
        $type = 2;

        $koneksi->query("INSERT INTO akun (email, password, nama, no_hp, type_user)
                          VALUES ('$email', '$password', '$nama', '$nope', '$type')");

        echo  '<script type="text/javascript">
                        swal({title: "Registrasi Berhasil!", 
                          text: "", 
                          icon: "success"
                        }).then(function() {
                          window.location = "login.php";
                        });
                     </script>';
      }
    }

  ?>

 <?php include "footer.php";?>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
  <script type="text/javascript">
    $(function(){
      $("form[name='daftarakun']").validate({
        rules:{
          email:{
            email : true
          },
          nama:{
            minlength : 5,
            maxlength : 100
          },
          nope:{
            digits : true,
            minlength : 3,
            maxlength : 20
          },
          password:{
            minlength: 6
          },
          password2:{
            equalTo: "#passw"
          }
        },
        messages:{
          email:{
            required: "<font color = 'red'>Email tidak boleh kosong!</font>",
            email: "<font color='red'>Format email salah!</font>"
          },
          nama:{
            required : "<font color = 'red'>Nama tidak boleh kosong!</font>",
            minlength : "Nama minimal 5 karakter.",
            maxlength : "Nama maksimal 100 karakter."
          },
          nope:{
            required : "<font color = 'red'>No. HP tidak boleh kosong!</font>",
            digits : "<font color = 'red'>Format tidak sesuai!</font>",
            minlength : "No. HP minimal 3 digit.",
            maxlength : "No. HP maksimal 20 digit."
          },
          password:{
            required : "<font color = 'red'>Password tidak boleh kosong!</font>",
            minlength : "Password minimal 6 karakter."
          },
          password2: {
            required : "<font color = 'red'>Konfirmasi Password harus diisi!</font>",
            equalTo : "<font color = 'red'>Password tidak sama!</font>"
          }
        }
      });
    });
  </script>

  <script>
    function hanyaAngka(evt) {
      var charCode = (evt.which) ? evt.which : event.keyCode
       if (charCode > 31 && (charCode < 48 || charCode > 57))
 
        return false;
      return true;
    }
  </script>

</body>
