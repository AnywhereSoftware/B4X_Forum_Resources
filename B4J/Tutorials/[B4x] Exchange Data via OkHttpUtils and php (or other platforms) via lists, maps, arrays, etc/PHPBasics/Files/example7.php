<?php

$mypw='Secret';

$jsonstring = file_get_contents("php://input"); //get the string or whatever you send via poststring

$mymap = array();
$mymap=json_decode($jsonstring, true);

$Action=$mymap['Action'];

switch ($Action)
	{
	Case "AESEncrypt":
		aes_encrypt('Test',$mypw );
		break;
	
	Case "AESDecrypt":
		$decrypted=aes_decrypt($mymap['b4xencrypted'],$mypw);
		$res=json_encode(array('AESDecrypt' => 'ok','b4xdecrypted' => $decrypted));
		$resencrypted=aes_encrypt($res,$mypw);
		exit($resencrypted);
		break;

default:
		print json_encode ("Error: Function not defined (" . $action . ")");
	}	 


function aes_encrypt($string, $pw)
	{
    $output = false;
    $pw=hash('sha256',$pw,true);
	$encrypt_method = "AES-256-CBC";
	$IV=openssl_random_pseudo_bytes(16, $securityok);
	$Salt=openssl_random_pseudo_bytes(32, $securityok);
	$output = openssl_encrypt($string, $encrypt_method, $pw, 0,$IV);
	$output=Base64_encode($Salt.$IV.Base64_decode($output));
	//$output is base64 encoded automatically!
    return $output;
	}	
function aes_decrypt($string, $pw) 
	{
	$pw=hash('sha256',$pw,true);
	$output = false;
    $encrypt_method = "AES-256-CBC";
	$total=base64_decode($string);
	$salt=substr($total, 0, 32);
	$iv=substr($total, 32, 16);
	$string=Base64_Encode(substr($total, 48, strlen($total)-48));
	$output = openssl_decrypt($string, $encrypt_method, $pw, 0,$iv);
	//$string must be base64 encoded!
	return $output;
	}
    


?>