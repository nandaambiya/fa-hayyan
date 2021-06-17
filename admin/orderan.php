<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/*" href="assets/img/fa_hayyan.png">
	<link rel="stylesheet" type="text/css" media="screen" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="https://cdn.datatables.net/1.10.22/css/dataTables.bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.22/js/dataTables.bootstrap.min.js"></script>
</head>
<body>

<h2>Daftar orderan</h2>
<br><br>

<table id="example" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <tr>
        	<th>No.</th>
			<th>No. Order</th>
			<th>Email Pemesan</th>
			<th>Tanggal Pesan</th>
			<th>Total Pembayaran</th>
			<th>Status Pesanan</th>
			<th></th>
        </tr>
    </thead>
    <tbody>
    <?php
        include 'koneksi.php';

        $nomor = 1;

        $produk = mysqli_query($koneksi,"select * from pesanan");
        while($row = mysqli_fetch_array($produk))
        {
        ?>
        <tr>
            <td><?= $nomor ?></td>
            <td><?= $row['id_pesanan'] ?></td>
            <?php
            	$user = $koneksi->query("SELECT * FROM akun WHERE id_akun = '$row[id_akun]'")->fetch_assoc();
            ?>
            <td><?= $user['email'] ?></td>
            <td><?= $row['tanggal_pesan'] ?></td>
            <td>Rp <?= number_format($row['subtotal_produk'] + $row['subtotal_pengiriman']) ?>,-</td>
            <td>
            	<?= $row['status_pesanan'] ?>
            </td>	
			<td>
				<a class="btn btn-info btn-sm" href="?halaman=detail&id=<?= $row['id_pesanan'] ?>"><i class="fa fa-list-alt"></i></a>
            	<?php if($row['status_pesanan'] == "Verifikasi Pembayaran" OR $row['status_pesanan'] == "Pembayaran Berhasil") : ?>
            		<a href="?halaman=bayar&id=<?= $row['id_pesanan'] ?>" class="btn btn-sm btn-success">Proses</a>
            	<?php endif ?>
            </td>
        </tr>

    <?php
    	$nomor++;
        }
    ?>

    </tbody>
</table>
    <script>
    $(document).ready(function(){
        $('#example').DataTable();
    });
</script>		

</body>
</html>