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
<h2>Data Edisi Produk</h2>
<br>
<!-- <a class="btn btn-info" href="index.php?halaman=inputbarang">Tambah Barang</a> -->
<br>
<br>
<a class="btn btn-sm btn-info" href="?halaman=produk_edisi_tambah">Tambah Edisi</a>
<br>
<br>
<table id="example" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <tr>
			<th>Kode</th>
			<th>Nama Edisi</th>
            <th width="200"></th>
        </tr>
    </thead>
    <tbody>
    <?php
        include 'koneksi.php';
        $produk = mysqli_query($koneksi,"select * from kategori_produk_edisi");
        while($row = mysqli_fetch_array($produk))
        {
    ?>
        <tr>
            <td><?= $row['id_edisi'] ?></td>
            <td><?= $row['edisi'] ?></td>
            <td>
                <a class="btn btn-sm btn-default" href="?halaman=detail_edisi&id=<?= $row['id_edisi'] ?>">Lihat Detail</a>
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