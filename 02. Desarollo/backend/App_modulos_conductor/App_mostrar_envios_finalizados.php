<?php 

include_once("config.php");

if ( isset($_POST['id_Conductor'] ) and $_POST['id_Conductor']!="") {
    
        $id_Conductor = mysqli_real_escape_string($db,$_POST['id_Conductor']);
        $sql = " CALL usp_App_Conductor_Envios_Finalizados ( '$id_Conductor' ) ";
        $result = mysqli_query( $db , $sql);
        
        
        if($result){
            $count = mysqli_num_rows($result);
            if( $count > 0 ){
                $data = array();
                while($row = mysqli_fetch_array($result)){
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