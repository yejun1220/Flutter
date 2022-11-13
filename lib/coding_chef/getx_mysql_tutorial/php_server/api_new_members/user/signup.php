<?php
include '../connection.php';

$userName = $_POST['user_name'];
$userEmail = $_POST['user_email'];
$userPassword = md5($_POST['user_password']);

$sqlQuery = "INSERT INTO user_table SET user_name = '$userName',
 user_email = '$userEmail', user_password = '$userPassword'";

// arrow : 객체에 접근하기 위한 연산자
 $resultQuery = $connection -> query($sqlQuery);

 if($resultQuery) {
    // echo : '작성한다.'의 의미
    // fat arrow : 값을 할당할 때 사용
    echo json_encode(array("success" => true));
 } else {
    echo json_encode(array("success" => false));
 }