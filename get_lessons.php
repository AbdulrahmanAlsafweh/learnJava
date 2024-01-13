<?php

include "connection.php";

$sql = "SELECT * FROM lessons";

$result = $connect->query($sql);

if ($result) {
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    echo json_encode($data);
} else {
    echo "Error: " . $sql . "<br>" . $connect->error;
}
?>