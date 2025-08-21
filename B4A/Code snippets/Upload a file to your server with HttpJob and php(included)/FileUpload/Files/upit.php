<?php
$br = "<br />";
if (isset($_REQUEST['DeviceID'])){$DeviceID=trim($_REQUEST['DeviceID']);} else {$DeviceID="0";}

$file_handle = fopen('./b4a.fileupload.log', 'a+');
fwrite($file_handle, "======================================"."\r\n");
foreach($_REQUEST as $name => $value){
	$add = "";
	fwrite($file_handle, date("d.m.Y H:i:s", time()).": ".$name."=".$value." ".$add."\r\n");
}
fwrite($file_handle, "======================================"."\r\n");

#echo "DeviceID = ".$DeviceID.$br;
#echo "json = ".$json.$br;


$res = array();
$res["resultcode"] = 0;
$uploads[] = array();
fwrite($file_handle, "======= FILES ========================"."\r\n");
fwrite($file_handle, "-------------scottwashere"."\r\n");
foreach($_FILES as $name => $value){
  $uploads[$name] = $value;
  foreach($value as $fname => $fvalue){
  	fwrite($file_handle, date("d.m.Y H:i:s", time()).": ".$fname."=".$fvalue."\r\n");
  }
 	fwrite($file_handle, date("d.m.Y H:i:s", time()).": Upload of \"".$name."\"\r\n");
 


 ///if($name=="File"){


    $uploaddir = './uploads/';
fwrite($file_handle, "-------------scottwashere 2"."\r\n");
    $uploadfile = $uploaddir . basename($_FILES[$name]['name']);
   	fwrite($file_handle, date("d.m.Y H:i:s", time()).": MoveUploadedFile(".$_FILES[$name]['name'].")\r\n");
fwrite($file_handle, "-------------scottwashere 3"."\r\n");
    if (move_uploaded_file($_FILES[$name]['tmp_name'], $uploadfile)) {
      $uploads[$name]["status"] = $_FILES[$name]['name']." saved successfull";
      $uploads[$name]["url"] = "http://192.168.1.14/uploads/".$_FILES[$name]['name'];
    	fwrite($file_handle, date("d.m.Y H:i:s", time()).": ->moving ".$_FILES[$name]['name']." successfull\r\n");
      #echo "Datei ist valide und wurde erfolgreich hochgeladen.\n";
    } else {
      $uploads[$name]["status"] = $_FILES[$name]['name']." failed to save!";
     	fwrite($file_handle, date("d.m.Y H:i:s", time()).":->moving ".$_FILES[$name]['name']." NOT successfull\r\n");
      #echo "Möglicherweise eine Dateiupload-Attacke!\n";
    }
  }
  foreach($value as $fname => $fvalue){
  	fwrite($file_handle, date("d.m.Y H:i:s", time()).": ".$fname."=".$fvalue."\r\n");
  }
  fwrite($file_handle, "======================================"."\r\n");
	#print_r($uploads);
  $appresult["uploads"] = $uploads;



///}



echo json_encode($appresult);
fclose($file_handle);
#echo '<a href="PDFs/output.pdf" target="_blank">output.pdf</a>';;
?>