<?php
   include("config.php");

      
      $sql = "SELECT * FROM cuenta_personas";
      
      $result = mysqli_query($db,$sql);
      
      //echo $result==null?'null':'false';
      echo $result==null?"es nulo":"tiene datos";
      
      //$count = mysqli_num_rows($result);
      
      //echo $count;
      
      //$row = mysqli_fetch_array($result);

   
?>