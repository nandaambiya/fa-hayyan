<head>
	<link rel="icon" type="image/*" href="icon/fa_hayyan.png">
	<?php include 'scrsty.php'; ?>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<?php
	session_start();

	foreach ($_SESSION['cart'] as $id => $jumlah) {

		$input = 'jumlah'.$id;

		$jumlah =  $_GET[$input];

		$_SESSION['cart'][$id] = $jumlah;
	}

	echo  '<script type="text/javascript">
                        swal({title: "BERHASIL!", 
                          text: "Data keranjang berhasil di-update", 
                          icon: "success"
                        }).then(function() {
                          window.location = "keranjang.php";
                        });
                     </script>';
?>
</body>