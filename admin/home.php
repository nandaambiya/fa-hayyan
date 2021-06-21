<style type="text/css">
      #container{
        position: relative;
        width: 100%;
        height: 300px;
        background-image: url('img/laptop.jpg');
        background-color: cover;
        background-size: 600px;
      }
      .avatar{
        position: absolute;
        top: 75%;
        left: 47%;
      }
      .avatar img{
        width: 120px;
        height: 120px;
        border-radius: 100%;
        border: 10px solid white;
      }
      .avatar2{
        position: absolute;
        top: 75%;
        left: 28%;
      }
      .avatar2 img{
        width: 120px;
        height: 120px;
        border-radius: 100%;
        border: 10px solid white;
      }
      .avatar3{
        position: absolute;
        top: 75%;
        left: 9%;
      }
      .avatar3 img{
        width: 120px;
        height: 120px;
        border-radius: 100%;
        border: 10px solid white;
      }
      .avatar4{
        position: absolute;
        top: 75%;
        left: 66%;
      }
      .avatar4 img{
        width: 120px;
        height: 120px;
        border-radius: 100%;
        border: 10px solid white;
      }
      .avatar5{
        position: absolute;
        top: 75%;
        left: 85%;
      }
      .avatar5 img{
        width: 120px;
        height: 120px;
        border-radius: 100%;
        border: 10px solid white;
      }
  </style>
<div id="container">
                    <div class="avatar">
                        <img src="img/avatar.png">
                    </div>
                    <div class="avatar2">
                        <img src="img/avatar.png">
                    </div>
                    <div class="avatar3">
                        <img src="img/avatar.png">
                    </div>
                    <div class="avatar4">
                        <img src="img/avatar.png">
                    </div>
                    <div class="avatar5">
                        <img src="img/avatar.png">
                    </div>

                </div>   <br><br> 
                <div class="row">
                    <div class="col-md-16">
                     <center><h1>Admin</h1>   
                        <h3>Hallo <?php echo $_SESSION['admin']['nama']; ?></h3></center>
                    </div>
                </div>
            
                 <!-- /. ROW  -->
                  <hr />