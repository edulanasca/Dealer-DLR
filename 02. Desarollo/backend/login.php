<?php
   include("Database/config.php");
   
   if($_SERVER["REQUEST_METHOD"] == "POST") {
      
        $myusername = mysqli_real_escape_string($db,$_POST['correo']);
        $mypassword = mysqli_real_escape_string($db,$_POST['pass']); 
        $password_encriptada = filter_var(sha1($mypassword),FILTER_SANITIZE_STRING);
        
        $sql = "CALL usp_App_Login( '$myusername','$password_encriptada' )";
        $result = mysqli_query($db,$sql);
      
        if(!$result){
            echo 'false';
        }else{
            $count = mysqli_num_rows($result);
            if($count > 0){
                $row = mysqli_fetch_array($result);
                mysqli_close($db); 
                echo json_encode($row);
            }
        }
   }
?>