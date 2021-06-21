

    <!--Main Navigation-->
    <header>

        <!--Navbar-->
        <nav class="navbar navbar-dark navbar-expand-lg scrolling-navbar">

            <div class="container">

                <!-- Navbar brand -->
               <ul class="navbar-nav">
            <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         Kategori
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown"style="background-color: #2a351f;">
          <a class="dropdown-item" href="kategori.php?kategori=Obat Kumur">Obat Kumur</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="kategori.php?kategori=Obat Bebas Terbatas">Obat Bebas Terbatas</a>
          <!-- <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Kategori 3</a> -->
        </div>
            </li>
            <!-- <li class="nav-item">
            <a href="edisi.php?item=2" class="nav-link waves-effect">
            Scrunchie
            </a>
            </li> -->
            <li class="nav-item">
            <a href="allstuff.php" class="nav-link waves-effect">
            Shop All
            </a>
            </li>
            </ul>

                <!-- Collapsible content -->
                <div class="collapse navbar-collapse justify-content-center" id="navbar">

                  <ul class="navbar-nav">
             <li class="nav-item">
                   <a class="navbar-brand" href="index.php">
            <img src="icon/logo_obat1.png" height="50">

              </a>
            </li>
          </ul>


              <!-- Right -->
             
            </div>
                    <!-- Links -->

                    <!-- Shopping cart icon -->
    <ul class="nav justify-content-end" >
    <ul class="navbar-nav ml-auto">
      
      <li class="nav-item">
        <a href="keranjang.php" class="nav-link navbar-link-2 waves-effect">
          <?php

            if (isset($_SESSION['customer']) && isset($_SESSION['cart'])){
              $isikeranjang = 0;

                foreach ($_SESSION['cart'] as $id => $jumlah) {
                  $isikeranjang += $jumlah;
                }
                
              echo "<span class='badge badge-pill badge-danger'>".$isikeranjang."</span>";
            }
          ?>
          <img src="icon/kuning1.png" height="30"> 
        </a>
      </li>

      <li class="nav-item">
        <a <?php if(isset($_SESSION['customer'])){echo "href='profil.php'";} else{echo "href='login.php'";} ?> class="nav-link navbar-link-2 waves-effect">
          <img src="icon/kuning2.png" height="30">
        </a>
      </li>
      <li class="nav-item">
    <a class="nav-link navbar-link-2 waves-effect" href="#!" data-toggle="modal" data-target="#myModal"><img src="icon/kuning.png" height="30"></a>
    </li>
      <!-- <li class="nav-item">
        <a href="review.php" class="nav-link navbar-link-2 waves-effect">
          <img src="icon/comment.png" height="20">
        </a>
      </li> -->
    </ul>
    </ul>

  <!-- Modal -->
  <div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-xl">
      <!-- konten modal-->
      <div class="modal-content modal-xl">
        <!-- heading modal -->
        <div class="modal-header modal-xl">
          <form action="search.php" method="get" class="form-inline form-xl">
            <input name="keyword" class="form-control" type="text" style="width: 376px;" placeholder="Search" aria-label="Search">
            <button class="btn" type="submit"><img src="icon/kuning.png" height="30"></button>
          </form>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
      </div>
    </div>
  </div>

    		</div>
        </nav>
  </header>
        <!--/.Navbar--> 




      



    
