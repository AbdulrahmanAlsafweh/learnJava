<?php
include "connection.php";


$username = $_POST['username'];
$password = $_POST['password'];


$sql = "select username,password,role from users where username like '$username'";

$res = mysqli_query($connect, $sql);

$response = array();

if (mysqli_num_rows($res) == 1) {
    while ($row = mysqli_fetch_array($res)) {
        if ($password == $row['password']) {
            $response['success'] = true;
            $response['message'] = 'Login successful';
            $response['role'] = $row['role'];
        } else {
            $response['success'] = false;
            $response['message'] = 'Incorrect password';
        }
    }
} else {
    $response['success'] = false;
    $response['message'] = 'Username not found';
}

echo json_encode($response);

?>