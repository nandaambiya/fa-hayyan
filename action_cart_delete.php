<head>
	<link rel="icon" type="image/*" href="icon/fa_hayyan.png">
	<?php include 'scrsty.php'; ?>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<?php
session_start();
$id_produk = $_GET["id"];

unset($_SESSION['cart'][$id_produk]);

echo  '<script type="text/javascript">
                        swal({title: "Item dihapus!", 
                          text: "", 
                          icon: "success"
                        }).then(function() {
                          window.location = "keranjang.php";
                        });
                     </script>';
?>
</body>