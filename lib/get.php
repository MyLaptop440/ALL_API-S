<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");           

$conn = mysqli_connect("localhost","root","","postapiphp");


if (isset($_GET['id'])) {   // Finding Single User Data
    $id = $_GET['id'];
    $where = " WHERE id = $id";
} else {
    $where = "";
}

$sql = "SELECT * FROM users2"   .$where;          // .$where for single record 

$result = mysqli_query($conn, $sql);
$data = [];
while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}
echo json_encode([
    "status"=>"success",
    "data"=>$data
]);


?>