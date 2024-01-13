<?php

$username = "id21727348_abdulrahman"; 
$password = "Alsafweh12#"; 
$host = "localhost";
$db_name = "id21727348_learnjava"; 


$connect = mysqli_connect($host, $username, $password, $db_name);


if (!$connect) {
    echo json_encode("Connection Failed");
}
?>