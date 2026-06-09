<?php

$conn = mysqli_connect("localhost", "root", "", "postapiphp");

if (
    isset($_POST['name']) &&
    isset($_POST['email']) &&
    isset($_POST['password'])
){

    $name = $_POST['name'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    $sql = "INSERT INTO users2(name, email, password)
    VALUES('$name', '$email', '$password')";

    if(mysqli_query($conn, $sql)){

        echo json_encode([
            "status" => "success",
            "message" => "User inserted successfully"
        ]);

    }else{

        echo json_encode([
            "status" => "failed",
            "message" => "Insert failed"
        ]);

    }

}else{

    echo json_encode([
        "status" => "error",
        "message" => "Name, Email or Password missing"
    ]);

}

?>