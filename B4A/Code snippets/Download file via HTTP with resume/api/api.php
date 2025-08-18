<?
error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);	//


$user = $_GET['username'];
$filename = $_GET['download'];
if (!$user || !$filename) {
	if($_SERVER['REQUEST_METHOD'] === "HEAD"){
		header('error: wrong parameter');
		header('http/1.0 404 not found');
		exit;
	}else{
		header('error: wrong parameter');
		die("Wrong parameters");
	}
}
$path = $_SERVER['DOCUMENT_ROOT'];
$domain = 'api';	//part of internal server's path to be removed 
$path = str_replace($domain, '', $path);
$path = $path . $filename;

if (!file_exists($path)) {
	header('http/1.0 404 not found');
	exit;
}

if($_SERVER['REQUEST_METHOD'] === "HEAD"){
	$fsize = filesize($path);
	$ftime = gmdate("D, d M Y H:i:s \G\M\T", filemtime($path)); 
	$ftimeunix = filemtime($path);
 	header('content-disposition: attachment; filename='.$filename);
	header('accept-ranges: bytes');
	header('content-length: '.$fsize);
	header('content-type: application/octet-stream');
	header('last-modified: '.$ftime);
	header('last-modified-unix: '.$ftimeunix);
	exit;
}


include 'cdownload.inc.php';

$download = @new cdownload($path,$filename,$user);
$download->enabledcountry = null;	//'localhost,local network,ua,ru';
$download->whitelist = null;	//'127.0.0.1,10.1.3.94';
$download->banlist = null;	//'184.12.13.5';
$download->username = $user;
$download->speedlimit = 1000; //kbps limit
$download->sizelimit = 0;	//2*mb;
$download->downloadfile();

?>