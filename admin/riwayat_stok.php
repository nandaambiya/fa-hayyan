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

<?php
    $id_produk = $_GET['id'];

?>

<body>
<h2>Riwayat Stok untuk <?= $_GET['nama']; ?></h2>
<h4>Kode Produk: <?= $id_produk ?></h4>
<br>
<table id="example" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <tr>
            <th width="30">No</th>
            <th>Keterangan</th>
            <th>Waktu</th>
            <th>Stok Lama</th>
            <th>Stok Baru</th>
        </tr>
    </thead>
    <tbody>
    <?php
        include 'koneksi.php';
        $riwayat = mysqli_query($koneksi,"SELECT aksi, stok_lama, stok_baru, timestamp FROM log_produk_stok WHERE id_produk = '$id_produk'");
        $i = 1;
        while($row = mysqli_fetch_array($riwayat))
        {
        ?>
        <tr>
            <td><?= $i ?></td>
            <td><?= $row['aksi'] ?></td>
            <td><?= $row['timestamp'] ?></td>
            <td><?= $row['stok_lama'] ?></td>
            <td><?= $row['stok_baru'] ?></td>
        </tr>
    <?php
            $i++;
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
        
</table>