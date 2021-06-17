<head>
    <link rel="icon" type="image/*" href="icon/fa_hayyan.png">
</head>
<?php
    $kota_asal = '70';
    $kota_tujuan = $_POST['kota_tujuan'];
    $kurir = $_POST['kurir'];
    $berat = $_POST['berat'] * 1000;

    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => "http://api.rajaongkir.com/starter/cost",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "POST",
        CURLOPT_POSTFIELDS => "origin=" . $kota_asal . "&destination=" . $kota_tujuan . "&weight=" . $berat . "&courier=" . $kurir . "",
        CURLOPT_HTTPHEADER => array(
            "content-type: application/x-www-form-urlencoded",
            "key: 2c30f7da50879c6c0b84f4a5990796b2"
        ),
    ));
    $response = curl_exec($curl);
    $err = curl_error($curl);
    curl_close($curl);
    $data = json_decode($response, true);
    //echo json_encode($data);

    $kurir = $data['rajaongkir']['results'][0]['name'];
    $kotaasal = $data['rajaongkir']['origin_details']['city_name'];
    $provinsiasal = $data['rajaongkir']['origin_details']['province'];
    $kotatujuan = $data['rajaongkir']['destination_details']['city_name'];
    $provinsitujuan = $data['rajaongkir']['destination_details']['province'];
    $berat = $data['rajaongkir']['query']['weight'] / 1000;
    // $idkota = $kotaasal = $data['rajaongkir']['origin_details']['city_id'];
?>

<div class="card">
    <h5 class="card-header text-black" style="background-color: .bg-secondary;">
        <b>Hasil pencarian:</b>
    </h5>          
    <div class="card-body">
    <form action="checkout.php" method="post">
        <table width="100%">
            <tr>
                <td width="15%"><b>Kurir</b> </td>
                <td>&nbsp;<b><?= $kurir ?></b></td>
                <input type="text" name="kurir" value="<?= $kurir ?>" hidden>
            </tr>
            <tr>
                <td>Dari</td>
                <td>: <?= $kotaasal . ", " . $provinsiasal ?></td>
            </tr>
            <tr>
                <td>Tujuan</td>
                <td>: <?= $kotatujuan . ", " . $provinsitujuan ?></td>
                <input type="text" name="kotaTujuan" value="<?= $kotatujuan ?>" hidden>
                <input type="text" name="provTujuan" value="<?= $provinsitujuan ?>" hidden>
            </tr>
        </table><br>
    <?php if (empty($data['rajaongkir']['results'][0]['costs'])): ?>
                <div align="left" class="alert alert-info" role="alert">
                    Kurir berikut tidak memiliki opsi pengiriman ke tujuan yang dipilih.<br>
                    Silakan pilih opsi kurir yang berbeda!
                </div>

    <?php else : ?>
        <table class="table table-striped table-bordered ">
            <thead>
                <tr>
                    <th>Nama Layanan</th>
                    <th>Tarif</th>
                    <th>ETD(Estimates Days)</th>
                    <th style="width: 37px"></th>
                </tr>
            </thead>
            <tbody>
            <?php
                foreach ($data['rajaongkir']['results'][0]['costs'] as $value) {
                    echo "<tr>";
                    echo "<td>" . $value['service'] . "</td>";

                    foreach ($value['cost'] as $tarif) {
                        echo "<td align='right'>Rp " . number_format($tarif['value']) . "</td>";
                        echo "<td>" . $tarif['etd'] . " D</td>";
                        echo "<td><input class='form-control' type='radio' required name='pilOngkir' value='".$value['service'].",".$tarif['value']."'></td>";
                    }

                    echo "</tr>";
                }
            ?>
            </tbody>
        </table>
        <button type="submit" name="submitOngkir" class="btn btn-kustom float-right">Pilih</button>
    </form>

    <?php endif ?>

    </div>
</div>
<?php
// print_r($idkota);
?>