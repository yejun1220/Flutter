<?php
include '../connection.php';

$userEmail = $_POST['user_email'];

$sqlQuery = "SELECT * FROM user_table WHERE user_email = '$userEmail'";

// arrow : 객체에 접근하기 위한 연산자
 $resultQuery = $connection -> query($sqlQuery);

 if($resultQuery -> num_rows > 0) {
    // echo : print, '작성한다.'의 의미,
    // fat arrow : 값을 할당할 때 사용
    // json 형태로 값을 넣어준다.
    echo json_encode(array("existEmail" => true));
 } else {
    echo json_encode(array("existEmail" => false));
 }