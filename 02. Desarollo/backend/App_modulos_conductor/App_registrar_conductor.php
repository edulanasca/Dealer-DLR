<?php 
include_once("config.php");

if (mysqli_connect_errno()) {
    exit();
}

if ( isset( $_POST['nombre'], $_POST['apellido'], $_POST['correo'], $_POST['pass'], $_POST['tipo'], $_POST['terminos'], $_POST['dni'], $_POST['celular'], $_POST['estado_cuenta'] )  and $_POST['nombre'] != "" and $_POST['apellido'] != "" and $_POST['correo'] != "" and $_POST['pass'] != "" and $_POST['tipo'] != "" and $_POST['terminos'] != "" and $_POST['dni'] != "" and $_POST['celular'] != "" and $_POST['estado_cuenta'] != "" ){

        $nombre = mysqli_real_escape_string($db,$_POST['nombre']);
        $apellido = mysqli_real_escape_string($db,$_POST['apellido']);
        $correo = mysqli_real_escape_string($db,$_POST['correo']);
        $pass = mysqli_real_escape_string($db,$_POST['pass']);
        $tipo = mysqli_real_escape_string($db,$_POST['tipo']);
        $terminos = mysqli_real_escape_string($db,$_POST['terminos']);
        $dni = mysqli_real_escape_string($db,$_POST['dni']);
        $celular = mysqli_real_escape_string($db,$_POST['celular']);
        $estado_cuenta = mysqli_real_escape_string($db,$_POST['estado_cuenta']);
        
        $encriptar_password = sha1($pass);
        
        $sql = "call usp_App_Conductor_Registrar_Usuario ('$nombre','$apellido','$correo','$encriptar_password','$tipo','$terminos','$dni','$celular','$estado_cuenta')";
        
        $result = mysqli_query($db,$sql);
        
        if($result){
            $row = mysqli_fetch_array($result);
            mysqli_close($db); 
            echo json_encode($row);
        }else{
            echo 'error';
        }  
        
}

?>