<?php

$servername = "localhost";

$username = "lowtancq_lowtancq_myshopadmin";

$password = "V2,WGZlu-RzI";

$dbname = "lowtancq_270910myshopdb";



$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {

die("Connection failed: " . $conn->connect_error);

}

?>