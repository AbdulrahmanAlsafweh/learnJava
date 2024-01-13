<?php

include "connection.php";

$lessonName = $_POST['LessonName'];
$lessonDesc = $_POST['LessonDesc'];
$lessonContent = $_POST['LessonContent'];

// Check for existing lesson names using prepared statement
$sql0 = "SELECT `name` from `lessons` where `name` like ?";
$stmt = $connect->prepare($sql0);
$stmt->bind_param("s", $lessonName);
$stmt->execute();
$result0 = $stmt->get_result();

if(mysqli_num_rows($result0) == 0){
    // No existing lesson name, proceed with insertion
    $sql = "INSERT INTO `lessons` (`name`, `description`, `content`,`summary`) VALUES (?, ?, ?,0)";
    $stmt = $connect->prepare($sql);
    $stmt->bind_param("sss", $lessonName, $lessonDesc, $lessonContent);

    if ($stmt->execute()) {
        echo "Data inserted successfully";
    } else {
        echo "Error inserting data";
    }
} else {
    echo "Lesson name already exists";
}

$stmt->close();
$connect->close();
?>
