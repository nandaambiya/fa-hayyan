<?php
	session_start();

  if (!isset($_SESSION['customer']) || empty($_SESSION['customer'])) {
        echo "<script> alert('Silakan login terlebih dahulu!'); </script>";
        echo "<script> window.location.href = 'login.php'; </script>";
  }

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

<?php include 'navbar.php'; ?>

	<div align="center" style="margin: 15px">
	<div class="card" style="width: 60rem; margin: 30px;">
		<div class="card-body">

		<h6 style="margin-bottom: 20px">Edit Data</h6>
		
		<form method="post" name="editdata">  
		 <div class="form-group row">
		    <label class="col-sm-2 col-form-label" for="nama">Nama</label>
		    <div class="col-sm-10">
		      <input required type="text" name="nama" class="form-control" id="nama" value="<?php echo $_SESSION['customer']['nama'] ?>">
		    </div>
		  </div>

		  <div class="form-group row">
		    <label class="col-sm-2 col-form-label" for="email">Email</label>
		    <div class="col-sm-10">
		      <input style="border: none;" required disabled type="email" name="email" class="form-control" id="email" value="<?php echo $_SESSION['customer']['email'] ?>">
		    </div>
		  </div>

		  <div class="form-group row">
		    <label class="col-sm-2 col-form-label" for="alamat">Alamat</label>
		    <div class="col-sm-10">
		      <textarea required type="text" name="alamat" class="form-control" id="alamat"><?php echo $_SESSION['customer']['alamat'] ?></textarea>
		    </div>
		  </div>

		  <div class="form-group row">
		   <label class="col-sm-2 col-form-label" for="kode_pos">Kode Pos</label>
		   <div class="col-sm-10">
		    <input required type="text" name="kode_pos" onkeypress="return hanyaAngka(event)" class="form-control" id="kode_pos" value="<?php echo $_SESSION['customer']['kode_pos'] ?>">
		   </div>
		  </div>

		 <div class="form-group row">
		  <label class="col-sm-2 col-form-label" for="nope">No Hp</label>
		  <div class="col-sm-10">
		    <input required type="text" name="nope" onkeypress="return hanyaAngka(event)" class="form-control" id="nope" value="<?php echo $_SESSION['customer']['no_hp'] ?>">
		  </div>
		  </div>

		 <div class="form-group row">
		    <label class="col-sm-2 col-form-label" for="passbaru" style="font-size: 13.5px !important;">Password baru (optional)</label>
		    <div class="col-sm-10">
		      <input type="password" name="passbaru" class="form-control" id="passbaru">
		    </div>
		  </div>

		  <div class="form-group row">
		    <label class="col-sm-2 col-form-label" for="konfpassbaru" style="font-size: 13.5px !important;">Konfirmasi password baru</label>
		    <div class="col-sm-10">
		      <input type="password" name="konfpassbaru" class="form-control" id="konfpassbaru">
		    </div>
		  </div>

		  <input type="password" id="passlama" hidden value="<?php echo $_SESSION['customer']['password'] ?>">

		  <div class="form-group row">
		    <label class="col-sm-2 col-form-label" for="konfpasslama" style="font-size: 13px !important;">Konfirmasi password lama</label>
		    <div class="col-sm-10">
		      <input type="password" name="konfpasslama" class="form-control" id="konfpasslama">
		    </div>
		  </div>

		  <button onclick="return confirm('Apakah Anda yakin untuk menyimpan data?')" class="btn btn-kustom float-right" name="simpandata" style="font-size: 15px; margin-left: 50px">Simpan</button>
		</form>
		</div>
	</div>
	</div>
	<a href="profil.php" class="btn btn-outline-secondary" style="font-size: 15px; margin-left: 200px">Kembali</a> 

<br><br>

<?php include 'footer.php'; ?>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
  <script type="text/javascript">
    $(function(){
      $("form[name='editdata']").validate({
        rules:{
          nama:{
            minlength : 5,
            maxlength : 100
          },
          email:{
            email : true
          },
          alamat:{
            minlength : 15
          },
          kode_pos:{
            digits : true,
            minlength : 5,
            maxlength : 5
          },
          nope:{
            digits : true,
            minlength : 5,
            maxlength : 20
          },
          passbaru:{
            minlength: 6
          },
          konfpassbaru:{
            equalTo: "#passbaru"
          },
          konfpasslama:{
            equalTo: "#passlama"
          }
        },
        messages:{
          nama:{
            required : "<font color = 'red'>Nama tidak boleh kosong!</font>",
            minlength : "Nama minimal 5 karakter.",
            maxlength : "Nama maksimal 100 karakter."
          },
          email:{
            required: "<font color = 'red'>Email tidak boleh kosong!</font>",
            email: "<font color='red'>Format email salah!</font>"
          },
          alamat:{
            required: "<font color = 'red'>Alamat tidak boleh kosong!</font>",
            minlength: "<font color='red'>Alamat harus spesifik!</font>"
          },
          kode_pos:{
            required : "<font color = 'red'>Kode pos tidak boleh kosong!</font>",
            digits : "<font color = 'red'>Format tidak sesuai!</font>",
            minlength : "Kode pos minimal 5 digit.",
            maxlength : "Kode pos maksimal 5 digit."
          },
          nope:{
            required : "<font color = 'red'>No. HP tidak boleh kosong!</font>",
            digits : "<font color = 'red'>Format tidak sesuai!</font>",
            minlength : "No. HP minimal 5 digit.",
            maxlength : "No. HP maksimal 20 digit."
          },
          passbaru:{
            minlength : "Password minimal 6 karakter."
          },
          konfpassbaru:{
            equalTo : "Password tidak sama."
          },
          konfpasslama: {
            required : "<font color = 'red'>Konfirmasi password lama diperlukan untuk menyimpan data!</font>",
            equalTo : "<font color = 'red'>Password salah! Diperlukan untuk menyimpan data.</font>"
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

<?php
	
	if (isset($_POST['simpandata'])){
		$email = $_SESSION['customer']['email'];

		if ($_POST['passbaru'] != '') {
			$koneksi->query("UPDATE akun SET 
									password = '$_POST[passbaru]',
									nama = '$_POST[nama]',
									alamat = '$_POST[alamat]',
									kode_pos = '$_POST[kode_pos]',
									no_hp = '$_POST[nope]' WHERE email = '$email'");
		}
		else{
			$koneksi->query("UPDATE akun SET
									nama = '$_POST[nama]',
									alamat = '$_POST[alamat]',
									kode_pos = '$_POST[kode_pos]',
									no_hp = '$_POST[nope]' WHERE email = '$email'");
		}

		$ambildatabaru = $koneksi->query("SELECT * FROM akun WHERE email = '$email'");
		$data = $ambildatabaru->fetch_assoc();
		$_SESSION['customer'] = $data;

		echo  '<script type="text/javascript">
                        swal({title: "Data Berhasil disimpan!", 
                          text: "", 
                          icon: "success"
                        }).then(function() {
                          window.location = "profil.php";
                        });
                     </script>';
	}

?>

</body>
</html>