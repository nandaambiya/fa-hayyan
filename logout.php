<head>
  <link rel="icon" type="image/*" href="icon/fa_hayyan.png">
	<?php include 'scrsty.php'; ?>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<?php
	session_start();

	session_destroy();

	echo  '<script type="text/javascript">
                        swal({title: "Logout Berhasil!", 
                          text: "", 
                          icon: "success"
                        }).then(function() {
                          window.location = "index.php";
                        });
                     </script>';
?>
</body>