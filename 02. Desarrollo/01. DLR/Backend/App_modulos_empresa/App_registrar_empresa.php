<?php 

include_once("config.php");

if ( isset($_POST['comercial'],$_POST['ruc'],$_POST['razon'],$_POST['direccion'],$_POST['interior'],$_POST['distrito'],$_POST['correo'],$_POST['celular'],$_POST['passw'],$_POST['tipo'],$_POST['status']) and $_POST['comercial']!="" and $_POST['ruc']!="" and $_POST['razon']!="" and $_POST['direccion']!="" and $_POST['interior']!="" and $_POST['distrito']!="" and $_POST['correo']!="" and $_POST['celular']!="" and $_POST['passw']!=""and $_POST['tipo']!=""and $_POST['status']!="") {
    /*
    echo 'entro';
        echo $_POST['comercial'];
        echo $_POST['ruc'];
        echo $_POST['razon'];
        echo $_POST['direccion'];
        echo $_POST['interior'];
        echo $_POST['distrito'];
        echo $_POST['correo'];
        echo $_POST['celular'];
        echo $_POST['passw'];
        echo $_POST['tipo'];
        echo $_POST['status'];
        
        echo sha1($_POST['passw']);
*/
        $comercial = mysqli_real_escape_string($db,$_POST['comercial']);
        $ruc = mysqli_real_escape_string($db,$_POST['ruc']);
        $razon = mysqli_real_escape_string($db,$_POST['razon']);
        $direccion = mysqli_real_escape_string($db,$_POST['direccion']);
        $interior = mysqli_real_escape_string($db,$_POST['interior']);
        $distrito = mysqli_real_escape_string($db,$_POST['distrito']);
        $correo = mysqli_real_escape_string($db,$_POST['correo']);
        $celular = mysqli_real_escape_string($db,$_POST['celular']);
        $passw = mysqli_real_escape_string($db,$_POST['passw']);
        $tipo = mysqli_real_escape_string($db,$_POST['tipo']);
        $status = mysqli_real_escape_string($db,$_POST['status']);
        
        $encriptar_password = sha1($passw);
        
        $sql = " CALL usp_App_Empresa_Registrar_Usuario ('$comercial','$ruc','$razon','$direccion','$interior','$distrito','$correo','$celular','$encriptar_password','$tipo','$status')";
        
        $result = mysqli_query($db,$sql);
        
        if($result != null){
            $count = mysqli_num_rows($result);
            if( $count > 0 ){
                $row = mysqli_fetch_array($result);
                mysqli_close($db); 
                
                echo json_encode($row);
            }
        }else{
            echo 'false';
        
        }
}
?>