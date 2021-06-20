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
<h2>Manajemen Satuan Jenis</h2>
<br>
<a class="btn btn-info" href="index.php?halaman=satuan_jenis_tambah">Tambah Data</a>
<br>
<br>
<table id="example" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <tr>
            <th width="30">No</th>
            <th>Satuan Jenis</th>
            <th width="50">Aksi</th>
        </tr>
    </thead>
    <tbody>
    <?php
        include 'koneksi.php';
        $jenis = mysqli_query($koneksi,"SELECT * FROM jenis_produk");
        while($row = mysqli_fetch_array($jenis))
        {
        ?>
        <tr>
            <td><?= $row['id_jenis'] ?></td>
            <td><?= $row['jenis'] ?></td>
            <td><a class="btn btn-sm btn-info" href="index.php?halaman=satuan_jenis_ubah&id=<?= $row['id_jenis'] ?>"><i class="fa fa-pencil"></i></a>
                <a class="btn btn-sm btn-danger" href="satuan_jenis_hapus.php?id=<?= $row['id_jenis'] ?>" onclick="return confirm('Yakin Ingin Menghapus Jenis Ini?')"><i class="fa fa-trash-o"></i></a>
            </td>
        </tr>
    <?php
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