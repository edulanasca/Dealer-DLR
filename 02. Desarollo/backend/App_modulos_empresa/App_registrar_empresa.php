<?php 

include_once("config.php");



if ( isset( $_POST['nombre_comercial'], $_POST['razon'], $_POST['ruc'], $_POST['correo'], $_POST['direccion'], $_POST['cantidad'], $_POST['celular'], $_POST['pass'], $_POST['resena'], $_POST['tipo'], $_POST['terminos'], $_POST['id_distrito'], $_POST['estado_cuenta'] )  and $_POST['nombre_comercial'] != "" and $_POST['razon'] != "" and $_POST['ruc'] != "" and $_POST['correo'] != "" and $_POST['direccion'] != "" and $_POST['cantidad'] != "" and $_POST['celular'] != "" and $_POST['pass'] != "" and $_POST['resena'] != "" and $_POST['tipo'] != "" and $_POST['terminos'] != "" and $_POST['id_distrito'] != "" and $_POST['estado_cuenta'] != "" ) {

        $nombre_comercial = mysqli_real_escape_string($db,$_POST['nombre_comercial']);
        $razon = mysqli_real_escape_string($db,$_POST['razon']);
        $ruc = mysqli_real_escape_string($db,$_POST['ruc']);
        $correo = mysqli_real_escape_string($db,$_POST['correo']);
        $direccion = mysqli_real_escape_string($db,$_POST['direccion']);
        $cantidad = mysqli_real_escape_string($db,$_POST['cantidad']);
        $celular = mysqli_real_escape_string($db,$_POST['celular']);
        $pass = mysqli_real_escape_string($db,$_POST['pass']);
        $resena = mysqli_real_escape_string($db,$_POST['resena']);
        $tipo = mysqli_real_escape_string($db,$_POST['tipo']);
        $terminos = mysqli_real_escape_string($db,$_POST['terminos']);
        $id_distrito = mysqli_real_escape_string($db,$_POST['id_distrito']);
        $estado_cuenta = mysqli_real_escape_string($db,$_POST['estado_cuenta']);

        $encriptar_password = sha1($pass);
        
        $sql = " CALL usp_App_Empresa_Registrar_Usuario ('$nombre_comercial', '$razon', '$ruc', '$correo', '$direccion', '$cantidad', '$celular', '$encriptar_password', '$resena', '$tipo', '$terminos', '$id_distrito', '$estado_cuenta')";
        
         
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