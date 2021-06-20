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
    $id_akun = $_GET['id'];

?>

<body>
<h2>Riwayat Data Diri untuk <?= $_GET['email']; ?></h2>
<h4>Kode Akun: <?= $id_akun ?></h4>
<br>
<table id="example" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <tr>
            <th width="30">No</th>
            <th>Nama</th>
            <th>Alamat</th>
            <th>Kode Pos</th>
            <th>Nomor HP</th>
            <th>Waktu</th>
        </tr>
    </thead>
    <tbody>
    <?php
        include 'koneksi.php';
        $riwayat = mysqli_query($koneksi,"SELECT nama_lama, alamat_lama, kode_pos_lama, no_hp_lama, waktu FROM log_edit_profil WHERE id_akun = '$id_akun'");
        $i = 1;
        while($row = mysqli_fetch_array($riwayat))
        {
        ?>
        <tr>
            <td><?= $i ?></td>
            <td><?= $row['nama_lama'] ?></td>
            <td><?= $row['alamat_lama'] ?></td>
            <td><?= $row['kode_pos_lama'] ?></td>
            <td><?= $row['no_hp_lama'] ?></td>
            <td><?= $row['waktu'] ?></td>
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