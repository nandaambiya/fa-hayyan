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

<h2>Data User Alliswell88.id</h2>
<table id="example" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <tr>
			<th>Nama</th>
			<th>Email</th>
			<th>Alamat</th>
			<th>Nomor HP</th>
			<th></th>
        </tr>
    </thead>

    <tbody>
    <?php
        include 'koneksi.php';
        $akun = mysqli_query($koneksi,"select * from akun");
        while($row = mysqli_fetch_array($akun))
        {
            echo "<tr>
            <td>".$row['nama']."</td>
            <td>".$row['email']."</td>
            <td>".$row['alamat']."</td>
            <td>".$row['no_hp']."</td>
			</td>
			
        </tr>"
        ;
        
        }
    ?>

    </tbody>

    <script>
    $(document).ready(function(){
        $('#example').DataTable();
    });
</script>

</table>
</body>
</html>

 
</script>
<!--
</table>
<h2>Data User Djadjan</h2>
<table class="table table-bordered">
	<thead>
		<tr>
			<th>No.</th>
			<th>Username</th>
			<th>Nama</th>
			<th>Email</th>
			<th>Alamat</th>
			<th>No. HP</th>
		</tr>
	</thead>
	<tbody>
		<?php

		$no = 1;
		$query = $koneksi->query("SELECT * FROM akun");

		while($user = $query->fetch_assoc()){ ?>
			<tr>
				<td><?php echo "$no"; ?></td>
				<td><?php echo "$user[username]"; ?></td>
				<td><?php echo "$user[nama]"; ?></td>
				<td><?php echo "$user[email]"; ?></td>
				<td><?php echo "$user[alamat]"; ?></td>
				<td><?php echo "$user[no_hp]"; ?></td>
				<?php if($user['level'] == 2) : ?>
				<td>
					<a class="btn btn-primary mr-3" href="index.php?halaman=riwayat&username=<?php echo "$user[username]" ?>">Riwayat</a>
					<a class="btn btn-danger" href="index.php?halaman=hapususer&username=<?php echo "$user[username]" ?>">Hapus</a>
				</td>
				<?php elseif($user['level'] == 1) : ?>
				<?php endif ?>
			</tr>
		<?php 
			$no++;
			}
		?>
		-->
	</tbody>
</table>