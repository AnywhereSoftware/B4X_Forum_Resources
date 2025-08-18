<?
define('kb',1024);
define('mb',kb*1024);

class cdownload {
# -------------------------------------------------------------------------------------
# Описание : выгрузка файла пользователю с поддержкой докачки и ограничением скорости
# -------------------------------------------------------------------------------------
var $downloadtimelimit = 300; # Лимит времени работы функции выгрузки
var $username = 'anonymous/'; # Пользователь по умолчанию
var $sizelimit = 0; # Лимит объема выгрузки (0 - без ограничений)
var $speedlimit = 100; # Лимит скорости выгрузки, кб/с
var $enablepartial = 1; # Разрешение докачки (0 - запрещена)
var $statfolder = 'stats/'; # Папка расположения статистики
var $filename; # Выгружаемый файл (должен быть задан!)
var $enabledcountry; # Разрешенные страны (список разделенный запятыми,
# null - разрешеные все)
var $disabledcountry; # Запрещенные страны (список разделенный запятыми)
var $whitelist; # Список разрешенных ip-адресов (список разделенный запятыми)
var $banlist; # Список запрещенных ip-адресов (список разделенный запятыми)
var $fn;
var $transferbytes = 0;

function cdownload($filename,$fn,$username) {
$this->filename = $filename;
$this->fn = $fn;
if ($username)
$this->username = preg_replace('[^0-9a-za-z_-]','',$username).'/';
$fullpath = $this->statfolder.$this->username;
if (!file_exists($fullpath))
mkdir($fullpath);
} # end cdownload

function verifyuser() {
if (
($this->whitelist && !in_array($_SERVER['REMOTE_ADDR'],explode(',',$this->whitelist))) ||
($this->banlist && in_array($_SERVER['REMOTE_ADDR'],explode(',',$this->banlist)))
) {
header('http/1.0 403 forbidden');
header('warning: 99# you ip address disabled');
exit;
}
}

function downloadfile() {
	$this->verifyuser();

	$blocksize = 8192;
	$headererrortext = 'error! a possible size is exceeded';

	$this->username = preg_replace('[^0-9a-za-z_-]','',$this->username).'/';
	//$this->filename = preg_replace('/.{2}/','',$this->filename);

	if (!file_exists($this->filename)) {
	header('http/1.0 404 not found');
	exit;
	}
	$fsize = filesize($this->filename);
	$ftime = gmdate("D, d M Y H:i:s \G\M\T", filemtime($this->filename)); 
	$ftimeunix = filemtime($this->filename);

	$fd = @fopen($this->filename, 'rb');
	if (!$fd) {
	header('http/1.0 403 forbidden');
	exit;
	}

	$res = preg_match("/bytes=([0-9]+)-/",$_SERVER['HTTP_RANGE'],$range);
	if ($this->enablepartial && $res) {
		header('http/1.1 206 partial content');
		$range = $range[1];
		fseek($fd, $range);
	} else{
		header('http/1.1 200 ok');
		$range = 0;
	}

	$fullpath = $this->statfolder.$this->username;
	$this->transferbytes = file($fullpath.$_SERVER['REMOTE_ADDR']);
	$this->transferbytes = $this->transferbytes[0];

	

	if ($this->sizelimit && $this->transferbytes>$this->sizelimit) {
		header('http/1.0 403 forbidden');
		header('warning: 99# '.$headererrortext);
		exit;
	}

	$fp = fopen($fullpath.$_SERVER['REMOTE_ADDR'],'w');
	$length = $fsize-$range;

	header('content-disposition: attachment; filename='.$this->fn);	//preg_replace('^.*/','',$this->filename));
	header('accept-ranges: bytes');
	header('content-length: '.$length);
	header('content-range: bytes '.$range.'-'.($fsize-1).'/'.$fsize);
	header('content-type: application/octet-stream');
	header('last-modified: '.$ftime);
	header('last-modified-unix: '.$ftimeunix);


//file_put_contents('log.txt', $ftime);

	set_time_limit($this->downloadtimelimit);

	while (!feof($fd)) {
		if ($this->sizelimit && $this->transferbytes>$this->sizelimit) {
		header('warning: 99# '.$headererrortext);
		exit;
		}
		echo fread($fd, $blocksize);
		$this->transferbytes += $blocksize;
		fseek($fp,0);
		fwrite($fp,$this->transferbytes);
		if ($this->speedlimit)
		usleep(8000000/$this->speedlimit);
	}
	fclose($fp);
	fclose($fd);
} # end downloadfile
}

?>