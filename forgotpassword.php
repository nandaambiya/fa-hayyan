 <?php
session_start();
//koneksi ke database
include 'koneksi.php';
?>

<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/*" href="icon/fa_hayyan.png">
    <meta charset="utf-8" />
    <?php include 'scrsty.php'; ?>
    <title>FA-HAYYAN</title>
</head>
<body>
<?php include "navbar.php";?>
<div class="container">
  <form action="#" class="login_design">
    <br> <br>
    <h2>Forgot Password</h2><br>
    <div class="form-group">
      <form class="form" role="form" autocomplete="off">
      <div class="form-group">
    <label for="inputResetPasswordEmail">Email</label>
    <input type="email" class="form-control" id="inputResetPasswordEmail" required="">
    <span id="helpResetPasswordEmail" class="form-text small text-muted"> Password reset instructions will be sent to this email address. </span>
    </div>
    <div class="form-group">
    <button type="submit" class="btn btn-success btn-lg">Reset</button>
    </div>                                                
</form>
</div>
</div>

        
 <?php include "footer.php";?>
</body>
</html>