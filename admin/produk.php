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
<h2>Data Produk</h2>
<br>
<a class="btn btn-info" href="index.php?halaman=inputbarang">Tambah Barang</a>
<br>
<br>
<table id="example" class="table table-striped table-bordered" style="width:100%">
    <thead>
        <tr>
			<th width="30">Kode</th>
			<th>Foto</th>
			<th>Nama</th>
            <th>Jenis</th>
			<th>Harga (Rp)</th>
			<th>Stok</th>
            <th width="142"></th>
        </tr>
    </thead>
    <tbody>
    <?php
        $produk = mysqli_query($koneksi,"SELECT id_produk, nama, harga, stok, gambar FROM listproduk GROUP BY id_produk");
        while($row = mysqli_fetch_array($produk)) {
    ?>
        <tr>
            <td><?= $row['id_produk'] ?></td>
            <td><img style="width: 100px" src="../image/<?= $row['gambar'] ?>"></td>
            <td><?= $row['nama'] ?></td>
            <td>
                <?php
                    $jenis = $koneksi->query("SELECT jenis FROM listproduk WHERE id_produk = '$row[id_produk]'");
                    $jumlah = $jenis->num_rows;
                    $i = 1;
                    while ($datajenis = $jenis->fetch_assoc()) {
                        echo $datajenis['jenis'];
                        if ($i < $jumlah) {
                          echo ", ";
                        }
                        $i++;
                    }
                ?>
            </td>
            <td><?= number_format($row['harga']) ?></td>
            <td><?= number_format($row['stok']) ?></td>
            <td><a class="btn btn-sm btn-info" href="?halaman=editbarang&id=<?= $row['id_produk'] ?>"><i class="fa fa-pencil"></i></a>
                <a class="btn btn-sm btn-success" href="#">Riwayat Stok</a>
                <a class="btn btn-sm btn-danger" href="hapusbarang.php?id=<?= $row['id_produk'] ?>" onclick="return confirm('Yakin ingin menghapus produk ini?')"><i class="fa fa-trash-o"></i></a>
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