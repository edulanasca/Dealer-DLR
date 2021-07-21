<?php 

include_once("config.php");

    
        //$id_Empresa = mysqli_real_escape_string($db,$_POST['id_Empresa']);
        
        
        $sql = " CALL usp_App_empresa_envios_asignados ( '17' ) ";
        
        
        $result = mysqli_query( $db , $sql);
        
        $count = mysqli_num_rows($result);
        
        echo $count;
        
        /*
        if($result != null){
            echo 'LLENO';
        }else{
            echo 'VACIO';
        }
        
        */
        /*
        
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
        
        */
        
    

?>