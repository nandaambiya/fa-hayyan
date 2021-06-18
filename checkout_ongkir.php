<?php
	session_start();

	include 'koneksi.php';

	if (!isset($_SESSION['customer']) || empty($_SESSION['customer'])) {
		echo "<script>alert('Silakan login terlebih dahulu!')</script>";
		echo "<script> window.location.href = 'login.php'; </script>";
	}
	else if (!isset($_SESSION['cart']) || empty($_SESSION['cart']) || !empty($_SESSION['cart']) == 0) {
		echo "<script>alert('Keranjang kamu kosong!')</script>";
		echo "<script> window.location.href = 'allstuff.php'; </script>";
	}

?>

<!DOCTYPE html>
<html lang="en">
<head>
  <link rel="icon" type="image/*" href="icon/fa_hayyan.png">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>FA-HAYYAN</title>

	<style type="text/css">
      .btn-kustom {
        color: #fff !important;
        background-color: #5d8975 !important;
        border-color: #5d8975 !important;
      }

      .btn-kustom:hover {
        color: #fff !important;
        background-color: #48695a !important;
        border-color: #48695a !important;
      }
    </style>
</head>
<body>

	<?php include 'navbar.php'; ?>

<div style="margin: 15px" align="center">
	  <div class="card" style="width: 73rem; margin: 30px;">
		<div class="card-body">

			<h5>Opsi Pengiriman</h5><br>

			<div class="row">
				<div class="col-sm-5">
                    <div class="card">
                        <h5 class="card-header text-black" style="background-color: .bg-secondary;">
                            Cek Ongkos Kirim
                        </h5>          
                        <div style="text-align: left !important;" class="card-body">
                            <form class="form" id="ongkir" method="POST">
                                <div class="form-group">
                                    <label class="control-label col-sm-4">Kota Asal</label>
                                    <div class="col-sm-12">
                                        <select class="form-control" disabled="true" name="kota_asal" required="">
                                            <option value="">Medan</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-4">Kota Tujuan</label>
                                    <div class="col-sm-12">          
                                        <select class="form-control" id="kota_tujuan" name="kota_tujuan" required="">
                                            <option></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-4">Kurir</label>
                                    <div class="col-sm-12">          
                                        <select class="form-control" id="kurir" name="kurir" required="">
                                            <option value="" selected="selected">--Pilih kurir--</option>
                                            <option value="jne">JNE</option>
                                            <option value="tiki">TIKI</option>
                                            <option value="pos">POS INDONESIA</option>
                                        </select>
                                    </div>
                                </div>

                                        <input type="text" hidden class="form-control" id="berat" name="berat" placeholder="Max. 30 KG" required="" value="1">

                                <div class="form-group">        
                                    <div class="col-sm-offset-3 col-sm-8">
                                        <button type="submit" class="btn btn-success col-sm-6 btn-kustom" id="tmblCek">Cek Ongkir</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-7" id="response_ongkir">

                </div>
			</div>

			<!-- <table width="100%">
				<tr>
			  		<th>Subtotal untuk Pengiriman</th>
			  		<th>Rp. ,-</th>
			  	</tr>
			</table> -->

		</div>
	</div>
</div>
	
<div style="margin: 15px" align="center">
	  <div class="card" style="width: 10rem; margin: 30px; border-style: none;">
			<a href="keranjang.php" class="btn btn-outline-secondary btn-block">Batal</a>
	  </div>
</div>

	<?php include 'footer.php'; ?>

	<link rel="stylesheet" href="assets/faicon/css/all.css">
	<link rel="stylesheet" href="assets/navbar.css">
	<link rel="stylesheet" href="assets/index.css">
	<link rel="stylesheet" href="assets/footer.css">
	<link rel="stylesheet" href="assets/css/style.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.1/css/select2.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.0/js/bootstrap.min.js"></script>
    <script src="assets/js/popper.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.1/js/select2.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.min.css'>

    <script type="text/javascript">
  $( document ).ready(function() {
  // $('#kota_asal').select2({
  //   placeholder: 'Binjai',
  //   language: "id"
  // });

  $('#kota_tujuan').select2({
    placeholder: '--Pilih kota/kabupaten tujuan--',
    language: "id"
  });

  // $.ajax({
  //   type: "GET",
  //   dataType: "html",
  //   url: "get_kota.php?q=kotaasal",
  //   success: function(msg){
  //     $("select#kota_asal").html(msg);                                                     
  //   }
  // });    
 
	$.ajax({
    type: "GET",
    dataType: "html",
    url: "get_kota.php?q=kotatujuan",
    success: function(msg){
      $("select#kota_tujuan").html(msg);                                                     
    }
  });

  $("#ongkir").submit(function(e) {
    e.preventDefault();
    $("#tmblCek").attr('disabled', true);
    $.ajax({
        url: 'cek_ongkir.php',
        type: 'post',
        data: $( this ).serialize(),
        success: function(data) {
          $("#tmblCek").attr('disabled', false);
          console.log(data);
          document.getElementById("response_ongkir").innerHTML = data;
        }
    });
  });

});
    </script>

<?php if ($_SESSION['customer']['alamat'] == '') : ?>
	<script type="text/javascript">
		swal({title: "Alamat Kosong!", 
			  text: "Harap isi data alamat terlebih dahulu!", 
			  icon: "warning"
			}).then(function() {
				window.location = "edit_profil.php";
			});
	</script>
<?php endif ?>

</body>
</html>