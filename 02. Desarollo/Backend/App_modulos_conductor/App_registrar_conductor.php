<?php 

include_once("config.php");

if ( 
    isset($_POST['nombre'],
    $_POST['apellido'],
    $_POST['correo'],
    $_POST['celular'],
    $_POST['passw'],
    $_POST['tipo'],
    $_POST['status']) and 
    $_POST['nombre']!="" and 
    $_POST['apellido']!=""  and 
    $_POST['correo']!="" and 
    $_POST['celular']!="" and 
    $_POST['passw']!=""and 
    $_POST['tipo']!=""and 
    $_POST['status']!="") {

       $nombre = mysqli_real_escape_string($db,$_POST['nombre']);
       $apellido = mysqli_real_escape_string($db,$_POST['apellido']);
       $correo = mysqli_real_escape_string($db,$_POST['correo']);
       $celular = mysqli_real_escape_string($db,$_POST['celular']);
       $passw = mysqli_real_escape_string($db,$_POST['passw']);
       $tipo = mysqli_real_escape_string($db,$_POST['tipo']);
       $status = mysqli_real_escape_string($db,$_POST['status']);
       $encriptar_password = sha1($passw);

$sql = " CALL usp_App_Conductor_Registrar_Usuario ('$nombre','$apellido','$correo','$celular','$encriptar_password','$tipo','$status')";
        $result = mysqli_query($db,$sql);
        
        if($result!=null){
            $row = mysqli_fetch_array($result);
            $count = mysqli_num_rows($result);
            mysqli_close($db); 
            
            echo json_encode($row);
        }else{
            echo null;
        
        }
        
        
        
}





?>