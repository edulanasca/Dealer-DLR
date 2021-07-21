<?php 

include_once("config.php");

   if($_SERVER["REQUEST_METHOD"] == "GET"){
       
        $sql = " CALL usp_App_Conductor_Envios_Disponibles() ";
        
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