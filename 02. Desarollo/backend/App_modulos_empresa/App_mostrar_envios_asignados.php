<?php 

include_once("config.php");

if ( isset($_POST['id_Empresa'] ) and $_POST['id_Empresa']!="") {
    
        $id_Empresa = mysqli_real_escape_string($db,$_POST['id_Empresa']);
        
        
        $sql = " CALL usp_App_Empresa_Envios_Asignados ( '$id_Empresa' ) ";
        
        
        $result = mysqli_query( $db , $sql);
        
        
        if($result){
            $count = mysqli_num_rows($result);
            if( $count > 0 ){
                $data = array();
                while($row = mysqli_fetch_array($result)){
                    /*
                    $aux = array();
                    $aux['ID_FICHA'] = $row['ID_FICHA'];
                    $aux['ID_EMPRESA'] = $row['ID_EMPRESA'];
                    $aux['FECHA_CREACION'] = $row['FECHA_CREACION'];
                    $aux['ESTADO'] = $row['ESTADO'];
                    $aux['MONTO'] = $row['MONTO'];
                    $aux['COORD_ORIGEN'] = $row['COORD_ORIGEN'];
                    $aux['COORD_DESTINO'] = $row['COORD_DESTINO'];
                    $aux['KM'] = $row['KM'];
                    $aux['EMPRESA'] = $row['EMPRESA'];
                    $aux['DIR_ORIGEN'] = $row['DIR_ORIGEN'];
                    $aux['ORIGEN_ID_DISTRITO'] = $row['ORIGEN_ID_DISTRITO'];
                    $aux['DIR_DESTINO'] = $row['DIR_DESTINO'];
                    $aux['DESTINO_ID_DISTRITO'] = $row['DESTINO_ID_DISTRITO'];
                    $aux['TIPO'] = $row['TIPO'];
                    $aux['PRODUCTO'] = $row['PRODUCTO'];
                    $aux['CLIENTE_NOMBRE'] = $row['CLIENTE_NOMBRE'];
                    $aux['CLIENTE_APELLIDO'] = $row['CLIENTE_APELLIDO'];
                    $aux['CLIENTE_CELULAR'] = $row['CLIENTE_CELULAR'];
                    */
                    
                    array_push($data,$row);
                }
                mysqli_close($db); 
                
                echo json_encode($data);
            }
        }else{
            echo 'error';
        
        }
        
        
}

?>