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

// GET DATA
$name = $_POST['name'];
$email = $_POST['email'];
$password = $_POST['password'];

// UPDATE QUERY
$sql = "UPDATE users2 SET
name='$name',
email='$email',
password='$password'
WHERE id='$id'";
// EXECUTE
$result = mysqli_query($conn, $sql);

// RESPONSE
if($result){

    echo json_encode([
        ["message"=>"User Updated Successfully"]
    ]);

}else{

    echo json_encode([
        ["message"=>"Update Failed"]
    ]);
}

?>