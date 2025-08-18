### [PHP] The Ultimate File Management PHP Functions by Mashiane
### 09/20/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/134401/)

Hi there  
  
Attached please find some useful php for file management. This is something that I have been wanting for a very long time, decided to create one myself.  
  
1. Zip a folder to a file  
2. UnZip a file to a target location  
3. Create a text file (recursively)  
4. Append to a text file  
5. Delete a file  
6. Check file existence  
7. Copy a file to another  
8. Get file contents  
9. Get ip  
10. Get HTML / JSON from URL  
11. Rename a file  
12. Create a folder (recursively)  
13. Create a log file  
14. Delete a folder (recursively)  
15. Rename / Move a folder  
16. Copy a folder to another  
17. Path info  
18. Get folder list of files  
19. Get folder list (recursively)  
20. Send email  
21. Delete a folder (recursively)  
  
  
Enjoy!  
  

```B4X
#if PHP  
  
/**  
* FlxZipArchive, Extends ZipArchiv.  
* Add Dirs with Files and Subdirs.  
*  
* <code>  
*  $archive = new FlxZipArchive;  
*  // …..  
*  $archive->addDir( 'test/blub', 'blub' );  
* </code>  
*/  
class FlxZipArchive extends ZipArchive {  
    /**  
     * Add a Dir with Files and Subdirs to the archive  
     *  
     * @param string $location Real Location  
     * @param string $name Name in Archive  
     * @author Nicolas Heimann  
     * @access private  
     **/  
  
    public function addDir($location, $name) {  
        $this->addEmptyDir($name);  
  
        $this->addDirDo($location, $name);  
     } // EO addDir;  
  
    /**  
     * Add Files & Dirs to archive.  
     *  
     * @param string $location Real Location  
     * @param string $name Name in Archive  
     * @author Nicolas Heimann  
     * @access private  
     **/  
  
    private function addDirDo($location, $name) {  
        $name .= '/';  
        $location .= '/';  
  
        // Read all Files in Dir  
        $dir = opendir ($location);  
        while ($file = readdir($dir))  
        {  
            if ($file == '.' || $file == '..') continue;  
  
            // Rekursiv, If dir: FlxZipArchive::addDir(), else ::File();  
            $do = (filetype( $location . $file) == 'dir') ? 'addDir' : 'addFile';  
            $this->$do($location . $file, $name . $file);  
        }  
    } // EO addDirDo();  
}  
  
function DirectoryCopy($src, $dst) {  
    //check the source directory  
    $source_exists = is_dir($src);  
    $target_exists = is_dir($dst);  
    if (!$source_exists) {  
        //source does not exist  
        die("no");  
    }  
    if ($target_exists) {  
        //target already exists  
        die("yes");  
    }   
    // open the source directory  
    $dir = opendir($src);   
    // Make the destination directory if not exist  
    mkdir($dst, 0700, true);  
    // Loop through the files in source directory  
    foreach (scandir($src) as $file) {   
        if (( $file != '.' ) && ( $file != '..' )) {   
            if ( is_dir($src . '/' . $file) )   
            {   
                // Recursively calling custom copy function  
                // for sub directory   
                DirectoryCopy($src . '/' . $file, $dst . '/' . $file);   
            }   
            else {   
                copy($src . '/' . $file, $dst . '/' . $file);   
            }   
        }   
    }   
    closedir($dir);  
    //return directory existence  
    $res = DirectoryExists($dst);  
    die($res);  
}    
  
function FileUnzip($zipfile, $extractTo) {  
    if (!file_exists($zipfile)) {  
        die("no");  
    }  
    // Create new zip class  
    $zip = new ZipArchive;  
    $zip->open($zipfile);  
    // Extracts to current directory  
    $zip->extractTo($extractTo);  
    $zip->close();  
    //return directory existence  
    $res = FileExists($extractTo);  
    die($res);   
}  
  
  
function DirectoryListRecursive($path) {  
    $target_exists = is_dir($path);  
    if (!$target_exists) {  
        //source does not exist  
        die("{}");  
    }  
    $iterator = new RecursiveDirectoryIterator($path);  
    // skip dot files while iterating  
    $iterator->setFlags(RecursiveDirectoryIterator::SKIP_DOTS);  
    $rii = new RecursiveIteratorIterator($iterator, RecursiveIteratorIterator::SELF_FIRST);  
  
    $files = array();  
    foreach ($rii as $file) {  
           $fname = $file->getPathname();  
        $fname = str_replace('\\', '/', $fname);  
        $files[] = $fname;  
    }  
         
    $output = json_encode($files);  
    die($output);  
}  
  
function DirectoryDelete($dir) {  
    $target_exists = is_dir($dir);  
    if (!$target_exists) {  
        //source does not exist  
        die("no");  
    }  
    $iter = new RecursiveDirectoryIterator($dir);  
    foreach (new RecursiveIteratorIterator($iter, RecursiveIteratorIterator::CHILD_FIRST) as $f) {  
        if ($f->isDir()) {  
            rmdir($f->getPathname());  
        } else {  
            unlink($f->getPathname());  
        }  
    }  
    rmdir($dir);  
    //return directory existence  
    $res = DirectoryExists($dir);  
}  
  
  
function DirectoryZip($path, $zipname) {  
    $target_exists = is_dir($path);  
    if (!$target_exists) {  
        //source does not exist  
        die("no");  
    }  
    $za = new FlxZipArchive;  
    $res = $za->open($zipname, ZipArchive::CREATE);  
    if($res === TRUE) {  
        $za->addDir($path, basename($path));  
        $za->close();  
    }  
    //return directory existence  
    $res = FileExists($zipname);  
}  
  
function FileGetJSON($url) {  
    $f = file_get_contents($url);  
    echo $f;  
}  
  
  
function FileGetHTML($url) {  
    $f = file_get_contents($url);  
    echo $f;  
}  
  
function DirectoryMake($dirpath) {  
    $target_exists = is_dir($dirpath);  
    if ($target_exists) {  
        die("yes");  
    }  
    mkdir($dirpath, 0700, true);  
    //return directory existence  
    $res = DirectoryExists($dirpath);  
    die($res);  
}  
  
function FileDelete($filex) {  
    if (file_exists($filex)) {  
        unlink($filex);  
    }  
    $res = FileExists($filex);  
    switch ($res) {  
      case "yes":  
        die("no");  
      case "no":  
        die("yes");  
    default:  
        die("no");  
    }  
}  
  
function FileExists($path) {  
    if (file_exists($path)) {  
        die("yes");  
    }else {  
        die("no");  
    }  
}  
  
function DirectoryExists($path) {  
    $target_exists = is_dir($path);  
    if (!$target_exists) {  
        //source does not exist  
        die("no");  
    }  
    die("yes");  
}  
  
  
  
function RollingCopyright($message,$year)  
{  
  die("$message &copy;$year-" . date("Y"));  
}  
  
function WriteFile($fileName, $fileContents) {  
    file_put_contents($fileName, $fileContents);  
    die(true);  
}  
  
function LogFile($fileName, $fileContents) {  
    $msg = date("Y-m-d H:i:s ") . $fileContents . "\n";  
    file_put_contents($fileName, $msg, FILE_APPEND);  
    die("yes");  
}  
  
function FileAppend($fileName, $fileContents) {  
    if (!file_exists($fileName)) {  
        die("no");  
    }  
    file_put_contents($fileName, $fileContents, FILE_APPEND);  
    die("yes");  
}  
  
function FileCopy($source, $target) {  
    // does the file / directory  
    if (!file_exists($source)) {  
        die("no");  
    }  
    if (!file_exists($target)) {  
        die("no");  
    }  
    copy($source, $target);  
    $res = FileExists($target);  
    die($res);  
}  
  
function FileRename($source, $target) {  
    // does the file / directory  
    if (!file_exists($source)) {  
        die("no");  
    }  
    //if target exists, no  
    if (file_exists($target)) {  
        die("no");  
    }  
    rename($source, $target);  
    $res = FileExists($target);  
    die($res);  
}  
  
function GetFile($fileName) {  
    // does the file / directory  
    if (!file_exists($fileName)) {  
        die("");  
    }  
    $f = file_get_contents($fileName);  
    die($f);  
}  
  
function GetPathInfo($fileName) {  
    // does the file / directory  
    if (!file_exists($fileName)) {  
        die("");  
    }  
    $path_parts = pathinfo($fileName);  
    $output = json_encode($path_parts);  
    die(output);  
}  
  
function SendEmail($from,$to,$cc,$subject,$msg) {  
    $msg = str_replace("|", "\r\n", $msg);  
    $msg = str_replace("\n.", "\n..", $msg);  
    // use wordwrap() if lines are longer than 70 characters  
    $msg = wordwrap($msg,70,"\r\n");  
    //define from header  
    $headers = "From:" . $from . "\r\n";  
    $headers .= "Cc: " . $cc . "\r\n";  
    $headers .= "X-Mailer:PHP/" . phpversion();  
    // send email  
    $response = (mail($to,$subject,$msg,$headers)) ? "success" : "failure";  
    $output = json_encode(array("response" => $response));  
    header('content-type: application/json; charset=utf-8');  
    die($output);  
}  
  
function DirectoryList($path) {  
    $files = array();  
    $dirs = array();  
    $fnum = $dnum = 0;  
    if (is_dir($path))  
   {  
      $dh = opendir($path);  
      do  
      {  
         $item = readdir($dh);  
         if ($item !== FALSE && $item != "." && $item != "..")  
         {  
            if (is_dir("$path/$item")) $dirs[$dnum++] = $item;  
            else $files[$fnum++] = $item;  
         }  
      } while($item !== FALSE);     
      closedir($dh);  
   }   
   $resp['dnum'] = $dnum;  
   $resp['fnum'] = $fnum;  
   $resp['dirs'] = $dirs;  
   $resp['files'] = $files;  
   $output = json_encode($resp);  
   die($output);  
}  
  
function ValidateCC($number, $expiry)  
{  
   $ccnum  = preg_replace('/[^\d]/', '', $number);  
   $expiry = preg_replace('/[^\d]/', '', $expiry);  
   $left   = substr($ccnum, 0, 4);  
   $cclen  = strlen($ccnum);  
   $chksum = 0;  
   
   // Diners Club  
   if (($left >= 3000) && ($left <= 3059) ||  
       ($left >= 3600) && ($left <= 3699) ||  
       ($left >= 3800) && ($left <= 3889))  
      if ($cclen != 14) die(FALSE);  
   
   // JCB  
   if (($left >= 3088) && ($left <= 3094) ||  
       ($left >= 3096) && ($left <= 3102) ||  
       ($left >= 3112) && ($left <= 3120) ||  
       ($left >= 3158) && ($left <= 3159) ||  
       ($left >= 3337) && ($left <= 3349) ||  
       ($left >= 3528) && ($left <= 3589))  
      if ($cclen != 16) die(FALSE);  
   
   // American Express  
   elseif (($left >= 3400) && ($left <= 3499) ||  
           ($left >= 3700) && ($left <= 3799))  
      if ($cclen != 15) die(FALSE);  
   
   // Carte Blanche  
   elseif (($left >= 3890) && ($left <= 3899))  
      if ($cclen != 14) die(FALSE);  
   
   // Visa  
   elseif (($left >= 4000) && ($left <= 4999))  
      if ($cclen != 13 && $cclen != 16) die(FALSE);  
   
   // MasterCard  
   elseif (($left >= 5100) && ($left <= 5599))  
      if ($cclen != 16) die(FALSE);  
        
   // Australian BankCard  
   elseif ($left == 5610)  
      if ($cclen != 16) die(FALSE);  
   
   // Discover  
   elseif ($left == 6011)  
      if ($cclen != 16) die(FALSE);  
   
   // Unknown  
   else die(FALSE);  
   
   for ($j = 1 - ($cclen % 2); $j < $cclen; $j += 2)  
      $chksum += substr($ccnum, $j, 1);  
   
   for ($j = $cclen % 2; $j < $cclen; $j += 2)  
   {  
      $d = substr($ccnum, $j, 1) * 2;  
      $chksum += $d < 10 ? $d : $d - 9;  
   }  
   
   if ($chksum % 10 != 0) die(FALSE);  
   
   if (mktime(0, 0, 0, substr($expiry, 0, 2), date("t"),  
      substr($expiry, 2, 2)) < time()) die(FALSE);  
     
   die(TRUE);  
}
```