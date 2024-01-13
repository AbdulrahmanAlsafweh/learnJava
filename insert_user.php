<?php

include "connection.php";

$username = $_POST['username'];
$password = $_POST['password'];

// Check for existing usernames using prepared statement
$sql0 = "SELECT `username` from `users` where `username` like ?";
$stmt = $connect->prepare($sql0);
$stmt->bind_param("s", $username);
$stmt->execute();
$result0 = $stmt->get_result();

if(mysqli_num_rows($result0) == 0){
    // No existing username, proceed with insertion
    $sql = "INSERT INTO `users` (`username`, `password`, `role`) VALUES (?, ?, 0)";
    $stmt = $connect->prepare($sql);
    $stmt->bind_param("ss", $username, $password);

    if ($stmt->execute()) {
        echo "Data inserted successfully";
    } else {
        echo "Error inserting data";
    }
} else {
    echo "Username already exists";
}

$stmt->close();
$connect->close();
?>
