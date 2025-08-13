<?php
	$host = "localhost";	
	$user = "myuser";
	$pass = "mypassword";
	$db = "demo_b4a";
	$mysqli = new mysqli($host, $user, $pass, $db) or die($mysqli->error);

	// $server = "http://demo.computerise.my/b4a/";
	$server = "http://192.168.43.191:8000/register-user-php/";
	$admin = "mailer@computerise.my";
	$sender = "no-reply@computerise.my";
?>