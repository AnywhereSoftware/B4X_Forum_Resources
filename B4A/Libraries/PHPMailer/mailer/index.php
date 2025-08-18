<?php
include('mailer.php');
$from = "info@[host].com";
$fromName = "From";
$email = $_GET['email'];
$name = $_GET['name'];
$to = array($email => $name);
$subject = $_GET['subject'];
$message = $_GET['message'];
$canButton = $_GET['canButton'];
$buttonAction = $_GET['buttonAction'];
$buttonText = $_GET['buttonText'];
$preheader = $_GET['preheader'];
$endText = $_GET['endText'];
$logo = $_GET['logo'];
include('html.php');
$mail = send_mail($from,$fromName,$to,$subject,$html);
if($mail){
	echo 1;
}else{
	echo 0;
}
?>