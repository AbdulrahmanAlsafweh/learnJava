<?php

include "connection.php";

$lessonName = $_POST['lessonName'];

// Check if the lesson exists
$sql0 = "SELECT `name` FROM `lessons` WHERE `name` = ?";
$stmt = $connect->prepare($sql0);
$stmt->bind_param("s", $lessonName);
$stmt->execute();
$result0 = $stmt->get_result();

if(mysqli_num_rows($result0) > 0){
    // Lesson exists, proceed with deletion
    $sql = "DELETE FROM `lessons` WHERE `name` = ?";
    $stmt = $connect->prepare($sql);
    $stmt->bind_param("s", $lessonName);

    if ($stmt->execute()) {
        // Deletion successful
        echo json_encode(array('success' => true));
    } else {
        // Error deleting lesson
        echo json_encode(array('success' => false, 'message' => 'Error deleting lesson'));
    }
} else {
    // Lesson does not exist
    echo json_encode(array('success' => false, 'message' => 'Lesson not found'));
}

$stmt->close();
$connect->close();
?>
