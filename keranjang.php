<?php
	session_start();

	include 'koneksi.php';
 ?>

<!DOCTYPE html>
<html>
<head>
	<title>FA-HAYYAN</title>
	<link rel="icon" type="image/*" href="icon/fa_hayyan.png">
    <?php include 'scrsty.php'; ?>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.min.css'>

	<style type="text/css">
      .btn-kustom {
        color: #fff;
        background-color: #2a351f;
        border-color: #2a351f;
      }

      .btn-kustom:hover {
        color: #fff;
        background-color: #5d8975;
        border-color: #5d8975;
      }
      .sampah:hover {
        color: #fff;
        background-color: #5d8975;
        border-color: #5d8975;
    </style>

</head>
<body>

<?php if (!isset($_SESSION['customer']) || empty($_SESSION['customer'])) : ?>
	<script type="text/javascript">
		swal({title: "BELUM LOGIN", 
			  text: "Harap login terlebih dahulu!", 
			  icon: "warning"
			}).then(function() {
				window.location = "login.php";
			});
	</script>
<?php endif ?>

<?php include 'navbar.php'; ?>
<br><br>
<?php if (empty($_SESSION['cart']) || !isset($_SESSION['cart'])) : ?>

<div align="center" style="margin: 75px">
	<h3>Your Cart is Empty!</h3><br><br><br>
<img src="icon/empty.gif" style="width: 200px;">
</div>

<?php else: ?>
	<h2 align="center">Isi Keranjangmu</h2>

	<div align="center">
	  <div class="card" style="width: 73rem; margin: 30px;">
		<div class="card-body">
			<table  class="" border="5" cellspacing="1" cellpadding="7">
			  <thead>
			    <tr>
			      <th>Produk</th>
			      <th></th>
			      <th>Harga Satuan</th>
			      <th>Jumlah</th>
			      <th>Subtotal</th>
			      <th></th>
			    </tr>
			  </thead>
			  <tbody>
	  <form action="updatekeranjang.php" method="get">
			  	<?php
			  		$total = 0;

			  		foreach ($_SESSION['cart'] as $id => $jumlah) :
			  	?>
			  	<?php
			  		$data = $koneksi->query("SELECT id_produk, nama_produk, foto_produk, harga_produk, stok_produk FROM produk WHERE id_produk = '$id'")->fetch_assoc();
			  		$subharga = $data['harga_produk'] * $jumlah;
			  	?>
			    <tr>
			      
			      	<td><a href="detail.php?id=<?php echo $id ?>"><img width="100px" src="image/<?php echo $data['foto_produk'] ?>"></a></td>
			      	<td><a style="color: inherit; text-decoration: none;" href="detail.php?id=<?php echo $id ?>"><?php echo $data['nama_produk']; ?></a></td>
			  		<td>Rp <?php echo number_format($data['harga_produk']); ?>,-</td>
			  		<td><input type="number" name="jumlah<?php echo $id ?>" value="<?php echo $jumlah; ?>" min="1" max="<?php echo $data['stok_produk']; ?>" style="width: 55px;" required></td>
			  		<td>Rp <?php echo number_format($subharga); ?>,-</td>
			  		<div class="sampah">
			  		<td style="text-align: right;"><a href="action_cart_delete.php?id=<?php echo $id ?>" onclick="return confirm('Yakin ingin menghapus item ini?')"><img src="icon/delete.png" style="width: 25px"></a></td></div>
			    </tr>
			    <?php $total+=$subharga ?>
				<?php endforeach ?>
			  </tbody>
			  <tfoot>
			  	
			  	<tr>
			  		<th>Subtotal</th>
			  		<th></th>
			  		<th></th>
			  		<th></th>
			  		<td style="text-align: right;">
			  			<strong>Rp <?php echo number_format($total); ?>,-</strong>
			  			<br>
			  			Belum termasuk ongkos kirim
			  		</td>
			  		<td></td>
			   	</tr>
			  </tfoot>
			</table>
		</div>
	  </div>
	  <div style="margin: 30px">
	    <button type="submit" class="btn btn-secondary" onclick="return confirm('Yakin ingin merubah isi keranjang?')">Update Data</button>
	    &nbsp;&nbsp;
	    <a href="checkout_ongkir.php" class="btn btn-kustom">Checkout</a>
	  </div>
	</form>
	</div>

<?php endif ?>
<br><br>
<?php include 'footer.php'; ?>

</body>
</html>