<?php
$json['receipt-data'] = $_GET['receipt'];
$json['password'] = "yyyyyyyyyyyyyyy-yoursecret-yyyyyyyyyyyy";
$json['exclude-old-transactions'] = true;
$testing = $_GET['calltype'];
$url = "";
if($testing == 'prod'){
    $url = "https://buy.itunes.apple.com/verifyReceipt";
}else if($testing == 'debug'){
    $url = "https://sandbox.itunes.apple.com/verifyReceipt";
}
$post = json_encode($json);
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL,$url);
curl_setopt($ch, CURLOPT_POST,1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
$result=curl_exec ($ch);
curl_close ($ch);
print_r ($result, true);
?>