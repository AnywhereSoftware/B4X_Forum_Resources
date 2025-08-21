<?php

$jsonstring = file_get_contents("php://input"); //get the string or whatever you send via poststring

$mymap = array();
$mymap=json_decode($jsonstring, true);

$Action=$mymap['Action'];

switch ($Action)
	{
	Case "SaveFile":

		$filename=$mymap["Filename"];
		$foldername=$mymap["Foldername"];
		$filecontent=$mymap["Filecontent"];

		if (!file_exists($foldername)) //Does the folder exist? "!" means "not"
			{
				if (!mkdir($foldername, 0777, true)) //Create the folder
				{
					die("Unable to create folder " . $foldername); //"die" is like "return" in B4x and exits the script at once
				}
			}

		file_put_contents($foldername . '/'. $filename, $filecontent);

		//Just send back a simple string
		print 'File  ' . $filename . ' was saved under /' . $foldername;
		break;

	Case "GetFile":
		$filename=$mymap["Filename"];
		$foldername=$mymap["Foldername"];
		
		if (!file_exists($foldername . "/" . $filename)) //Does the folder & file exist? "!" means "not"
			{
				print "Folder/File does not exist...";
			}
			else
			{
				$filecontent = file_get_contents($foldername . "/" . $filename, true);
				$res=json_encode(array('GetFile' => 'ok','Filename' => $filename, 'Filecontent' => $filecontent));
				echo $res;
			}
		break;
default:
		print json_encode ("Error: Function not defined (" . $Action . ")");
	}	

?>