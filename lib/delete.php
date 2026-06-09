<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");

$conn = mysqli_connect("localhost", "root", "", "postapiphp");

if(!$conn){
    echo json_encode([
        ["message"=>"Database Connection Failed"]
    ]);
    exit();
}

// GET ID
$id = $_GET['id'];

// DELETE QUERY
$sql = "DELETE FROM users2 WHERE id='$id'";

// EXECUTE
$result = mysqli_query($conn, $sql);

// RESPONSE
if($result){

    echo json_encode([
        ["message"=>"User Deleted Successfully"]
    ]);

}else{

    echo json_encode([
        ["message"=>"Delete Failed"]
    ]);
}

?>