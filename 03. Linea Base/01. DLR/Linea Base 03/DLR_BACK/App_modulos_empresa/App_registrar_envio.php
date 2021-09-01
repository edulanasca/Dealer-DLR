<?php 

include_once("config.php");

if ( isset( $_POST['nombre'], $_POST['apellido'], $_POST['documento'], $_POST['celular'], $_POST['direccion'], $_POST['distrito'], $_POST['producto'], $_POST['descripcion'], $_POST['SizeProduct'], $_POST['delicado'], $_POST['tipoenvio'], $_POST['idempresa'], $_POST['estado'], $_POST['kilometros'], $_POST['coord_origen'], $_POST['coord_destino'], $_POST['costo']) and  $_POST['nombre']!="" and  $_POST['apellido']!="" and  $_POST['documento']!="" and  $_POST['celular']!="" and  $_POST['direccion']!="" and  $_POST['distrito']!="" and  $_POST['producto']!="" and  $_POST['descripcion']!="" and  $_POST['SizeProduct']!="" and  $_POST['delicado']!="" and  $_POST['tipoenvio']!="" and  $_POST['idempresa']!="" and  $_POST['estado']!="" and  $_POST['kilometros']!="" and  $_POST['coord_origen']!="" and  $_POST['coord_destino']!="" and  $_POST['costo']!="") {
    

        $nombre = mysqli_real_escape_string($db,$_POST['nombre']);
        $apellido = mysqli_real_escape_string($db,$_POST['apellido']);
        $documento = mysqli_real_escape_string($db,$_POST['documento']);
        $celular = mysqli_real_escape_string($db,$_POST['celular']);
        $direccion = mysqli_real_escape_string($db,$_POST['direccion']);
        $distrito = mysqli_real_escape_string($db,$_POST['distrito']);
        $producto = mysqli_real_escape_string($db,$_POST['producto']);
        $descripcion = mysqli_real_escape_string($db,$_POST['descripcion']);
        $SizeProduct = mysqli_real_escape_string($db,$_POST['SizeProduct']);
        $delicado = mysqli_real_escape_string($db,$_POST['delicado']);
        $tipoenvio = mysqli_real_escape_string($db,$_POST['tipoenvio']);
        $idempresa = mysqli_real_escape_string($db,$_POST['idempresa']);
        $estado = mysqli_real_escape_string($db,$_POST['estado']);
        $kilometros = mysqli_real_escape_string($db,$_POST['kilometros']);
        $coord_origen = mysqli_real_escape_string($db,$_POST['coord_origen']);
        $coord_destino = mysqli_real_escape_string($db,$_POST['coord_destino']);
        $costo = mysqli_real_escape_string($db,$_POST['costo']);
        
        $sql = "CALL usp_App_Empresa_Registrar_Envio ( '$nombre','$apellido','$documento','$celular','$direccion','$distrito','$producto','$descripcion','$SizeProduct','$delicado','$tipoenvio','$idempresa','$estado','$kilometros','$coord_origen','$coord_destino','$costo' )";
        
        
        
        $result = mysqli_query($db,$sql);
        
        if(!$result){
            echo 'error';
        }else{
            $count = mysqli_num_rows($result);
            if( $count > 0 ){
                $row = mysqli_fetch_array($result);
                mysqli_close($db); 
                
                echo json_encode($row);
            }
        }
}
?>