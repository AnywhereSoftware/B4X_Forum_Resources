### Syncing local databases using PHP to access a database on a hosted server by Cliff McKibbin
### 12/17/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/142126/)

My need was to sync calendars in which user 'A' changes the calendar and sends the change to other users by writing records to the hosted database.  
The other users query periodically to see it they have any incoming sync records and read them if available.  
  
I had hoped to use Erel's JDRC2 solution to access a remote database and had worked out most of the details until I attempted to set it up on a hosted website (1&1 Ionos).  
<https://www.b4x.com/android/forum/threads/b4x-jrdc2-b4j-implementation-of-rdc-remote-database-connector.61801/>  
  
When I posted the question to set it up on 1&1, I received the response that it would not support a hosted website.  
<https://www.b4x.com/android/forum/threads/jrdc2-how-to-start-the-server-on-a-hosted-website.140670/#post-891156>  
  
Quandalle's response did suggest that Ionos offers a small VPS S configuration so that I might have gone that way.  
  
Don Manfred suggested trying PHP and so I decided to look into that approach.  
  
I found the following PHP/SQL reference that helped a lot to reduce my learning curve.  
<https://www.geeksforgeeks.org/php-tutorials/?ref=lbp>  
  
Hopefully, the following discussion will further reduce the PHP learning curve for the next developer.  
If you have a VPS, however, you would want to stick with the JDRC2 approach.  
  
**So far, I have found:**  
1. While there are specialized editors for PHP, you can use Notepad to edit it.  
2. The PHP solution meets the primary objectives of the JDRC2 solution in that all host database password and SQL command access is at the website.  
3. The PHP program is self starting so that there is no requirement to 'start' the server.  
4. Response times to store multiple records or to query the server and bring down multiple records are sub-half-second.  
5. I am able to use HTTPS as 1&1 Ionos supports it.  
  
**In addition:**  
1. I have developed the 'TestPhp.B4A' program to test the PHP processing. It is modeled on Erel's B4A program included with the JDRC2 forum entry.  
 a. It includes writing to, reading from, and deleting from the hosted database.  
 b. It eliminates SQL injection from the Apps own records.  
 c. It handles the issue of internet inaccessability including during 'airplane' mode.  
 d. It does not include several of Erel's JDRC2 features such as transaction processing and multiple commands sent at one time.  
2. I have built into the php a recode of single and double quotes to eliminate SQL injection in case commands are sent from a nefarious actor.  
3. I have tested the program for receiving and parsing up to 100 records with no problem in under 1/2 second.  
  
**I have included below:**  
1. The 'TestPHP.PHP' program with explanations. The remote database table definition is included in the PHP program.  
2. The 'TestPHP.B4A' program with explanations.  
3. Steps to get the 'Test' environment up and running.  
4. Enhancements required for a full Sync application.  
5. Observations on using PHP for traditional database storage on a remote host.  
  
  
I am interested in comments/suggestions/problems related to either program.  
 a. I would especially like to hear of any issues related to security to further protect the PHP program as well as the database.  
 b. If anyone has suggestions on replicating some of Erel's features in JDRC2 such as transaction processing, multiple commands, and receiving multiple records that don't have to be parsed from a single string.  
  
  
**Notes on the 'TestPHP.PHP' program.** The full program is below and in an attachment. Note that the forum did not allow the upload of the TestPHP.PHP. I have uploaded it as TestPHP.txt. You can edit it as required, rename it, and load it up to your server.  
  
1. \*\* Note my first comment on 'Case'. Very important. If a variable is misspelled you will not be told why the progam did not work.  
  
2. The command line is first decoded. You only need to include variables as appropriate for each command. You will see this in the B4A program and in the command processing in the PHP program.  
  
3. The SQL injection elimination is next. In this case any single/double quotes are lost and will not be returned to the user.  
  
4. The database is opened. This is the format for 1&1 Ionos. Other hosts may be similar. Change the values as required for your database.  
  
5. The commands are processed in a 'Case' construct. You can modify the command names and functions as you wish.  
 BT-Build table. Modify table as needed. Note you can 'drop' the table and redefine it during testing.  
 IR-Insert. Modify as desired to insert a record.  
 SF-Set Flag. This concept will be discussed in the explanation of the B4A Test program.  
 DR-Delete Record. Deletes any flagged records for this user. This will be sent following a successful read of the flagged records.  
 RR-Read Record. Reads any flagged records for this user. Note that the records selected are concatonated into a single stream which must be parsed by the receiving B4A program.  
  
6. In all commands a record is 'echoed' back to the B4A program. I have included sentinels such as 'Tbl1', 'Set1', 'Rec1' to indicate success and 'Err1' to indicate failure. The B4A program will test for these before continuing.  
  
7. I have liberally used the construct '/r/n' which is equivalent to CRLF in order to improve the readability of the returned string which is visible at the bottom of the B4A test program screen.  
  
8. The DB and connection is closed.   
   
  

```B4X
<?php  
  
// *******Extremely important with php*********  
// You must observe 'case' when using all $vars.   $sql is not the same as $Sql  
// You will not get an error, it just won't work  
//  
$Command=htmlspecialchars($_GET["Cmd"]);  
$Id=htmlspecialchars($_GET["Id"]);  
$IdFrom=htmlspecialchars($_GET["IdF"]);  
$IdTo=htmlspecialchars($_GET["IdT"]);  
$Type=$Data=htmlspecialchars($_GET["Ty"]);  
$Data=htmlspecialchars($_GET["Dt"]);  
  
//replace single quote to prevent sql injection  
$Commnand=str_replace("'"," ",$Command);  
$Id=str_replace("'"," ",$Id);  
$IdFrom=str_replace("'"," ",$IdFrom);  
$IdTo=str_replace("'"," ",$IdTo);  
$Type=str_replace("'"," ",$Type);  
$Data=str_replace("'"," ",$Data);  
//replace double quote to prevent sql injection-note use of single quote to specify the replaced char-tricky  
$Commnand=str_replace('"'," ",$Command);  
$Id=str_replace('"'," ",$Id);  
$IdFrom=str_replace('"'," ",$IdFrom);  
$IdTo=str_replace('"'," ",$IdTo);  
$Type=str_replace('"'," ",$Type);  
$Data=str_replace('"'," ",$Data);  
  
echo "Cmd1: ".$Command." ".$Id." ".$IdFrom." ".$IdTo." ".$Type." ".$Data."\r\n";  
  
// Open the DataBase–must be modified to your values  
  $host_name = 'dbwwwwww.hosting-data.io';  
  $database = 'dbsxxxxx';  
  $user_name = 'dbuyyyyy';  
  $password = 'zzzzzz';  
   
  $link = new mysqli($host_name, $user_name, $password, $database);  
  if ($link->connect_error) {  
    die("Fail1:Failed to connect to MySQL: ". $link->connect_error ."\r\n");  
  } else {  
    echo "Conn1:Connection to MySQL \r\n";  
  }  
  
switch ($Command) {  
  case "BT":  
      //Remove // comments if you need to drop the table and start over  
      //$sql = "Drop TABLE tblSync";  
      //if ($link->query($sql) === TRUE) {  
      //  echo "Tbl1: Table tblSync dropped \r\n";  
      //} else {  
      //  echo "Err1: Error dropping table: " . $conn->error."\r\n";  
      //}  
    
      $sql = "CREATE TABLE if not exists tblSync (  
      Id text, IdFrom text, IdTo text, sType text, sFlag text, sData text )";  
      echo $sql."\r\n";  
  
      if ($link->query($sql) === TRUE) {  
        echo "Tbl1: Table tblSync created \r\n";  
      } else {  
        echo "Err1: Error creating table: " . $conn->error."\r\n";  
      }  
      Break;  
    
  case "IR":  
      $sql = "INSERT INTO tblSync ( Id , IdFrom , IdTo , sType, sFlag, sData )  
      VALUES ('".$Id."','".$IdFrom."','".$IdTo."','".$Type."','0','".$Data."')";  
      echo $sql."\r\n";  
      
     if ($link->query($sql) === TRUE) {  
        echo "Add1: New record added \r\n";  
      } else {  
        echo "Err1: Error: " . $sql . "<br>" . $conn->error. "\r\n";  
      }  
      break;  
   
     case "SF":  
       $sql = "Update tblSync set sFlag='1' where Id='".$Id. "' and IdTo='".$IdTo."' " ;  
       echo $sql."\r\n";  
     
     if ($link->query($sql) === TRUE) {  
        echo "Set1: Flag set to 1 \r\n";  
      } else {  
        echo "Err1: Error: " . $sql . "<br>" . $conn->error. "\r\n";  
      }  
      // now, get the record count  
      $sql="SELECT count(*) from tblSync where Id='".$Id. "' and IdTo='".$IdTo."' and sFlag='1'";  
      $count = $link->query($sql)->fetch_row()[0];  
      echo "Flag1 Records Flagged:<Ct>" . $count. "<ECt>\r\n";  
      break;  
   
    case "DR":  
       $sql = "Delete from tblSync where Id='".$Id. "' and IdTo='".$IdTo."' and sFlag='1' " ;  
       echo $sql."\r\n";  
     
     if ($link->query($sql) === TRUE) {  
        echo "Del1: Records Deleted \r\n";  
      } else {  
        echo "Err1: Error: " . $sql . "<br>" . $conn->error. "\r\n";  
      }  
      break;  
   
  case "RR":  
     $sql = "SELECT * FROM tblSync where Id='".$Id. "' and IdTo='".$IdTo."' and sFlag='1' order by IdFrom, sType" ;  
     echo $sql."\r\n";  
     //Run the Query  
      $result = $link->query($sql);  
     //If the query returned results, loop through each result  
     if ($result->num_rows > 0) {  
              while($row = $result->fetch_assoc()) {  
              echo "Rec1: <Ty>" .  $row['sType']."<IdF>".$row['IdFrom']."<Dt> ". $row['sData']. "<EDt>\r\n";  
         }  
         $result -> free_result();  
         } else {  
           echo "0 results \r\n";  
       }  
       break;  
    
//End Case  
}  
  
   // closing connection  
   $link->close();  
   echo "Close1:DB Closed";  
?>
```

  
  
  
**Notes on the 'TestPHP.B4A' program**. The B4A test program is in an attachment.  
  
1. It is set up to manually simulate the steps involved in a 'Sync' application. That is:  
 a. send a record to a specific user.  
 b. Receive a record from another user.  
 i. The user flags any records sent to him.  
 ii. The user reads any records sent to him.  
 iii. If the read is successful, the user deletes his own flagged records. This assures that records received in the seconds between the flag and the read are not deleted as they will not be flagged. They will be read on a subsequent query.  
  
2. Concept of the Id, FromId, and ToId.  
 a. In a Sync application, we will have a number of 'families' of users. Each family using the App will have a unique Id.  
 It could be an email address as a number of applications use. In our case, it is created by us at 'Install' time and consists of letters generated from the date/time of the Install plus an additional random number.  
 b. Each user within the family unit will put that Id into their 'settings'.  
 c. In addition, each individual user will have a unique Id. This allows us to selectively sync records. Thus, you might not want to sync a medical appointment to the children, or you might not want to sync some of your work info to your children.  
 d. Each record in this app is therefore sent to the appropriate ids for the particular category of information.  
 This implies that if you are syncing a record to 3 ids, you will send 3 records via the HTTPS, one to each of the users in the 'family'.  
   
3. The 'SType' data field allows you to send records for different tables. Define each record with an 'SType' code and build and parse them as required.  
  
4. Command Line Builds. The full build of each command line is illustrated.  
   
5. The test program shows an example of concatanating the data record from the fields in a table. The returned data string is surrounded with '<Dt>' and '<EDt>' to serve as sentinels to locate the data string.  
 In this test program, we are showing the concatenation of dummy fields with a character seperator of chr(154). Ditto, we show the parsing of the returned string with each record added to the clv for display.  
   
6. SQL injection.  
 a. As discussed above, the PHP program is eliminating sql injection of single and double quotes. This is primarily to prevent nefarious users attempting to take advantage of the system.  
 b. In the B4A program, we recode single and double quotes so we can replace them in the receiving program. The current recoding uses:  
 Single quote=chr(149)  
 Single quote=chr(150)  
 c. The 'PurgeChar' sub performs the conversion and the 'UnPurgeChar' performs the return.  
 d. Note that our test data has a single quote which is purged, sent, and unpurged.  
 e. Note that the return from 'Insert Record' is not un-purged so you can see that a special character was sent.  
 f. The return from 'Read Record' is un-purged.  
 g. Likewise, we have to remove any '&' from the data string as they are the sentinels to start a new variable in the command line.  
 & is recoded to chr(151). This conversion is performed in 'PurgeChar' as well.  
  
11/26/2023  
 In attempting to encrypt selected fields in our records we found some special characters caused drop-outs or insertion of extra characters in the messages sent to and from the server. The code below shows the new 'PurgeChar' and 'UnPurgeChar' subs that are now included in the zip file below.  
  

```B4X
Public Sub PurgeChar (S1 As String) As String  
    ' sub to replace single and double quotes from text for writing to sql  
    ' mod to chr 149, 150 1/30/20 cwm  
    S1=S1.replace ("'",Chr(149))            ' single quote  
    S1=S1.Replace (Chr(34), Chr(150))    ' double quote  
    S1=S1.Replace ("&", Chr(151))        ' added 6/8/22 For sync  cwm  
    S1=S1.Replace (Chr(10), Chr(152))    ' added 6/8/22 For sync  cwm  
    S1=S1.Replace (Chr(13),Chr(155))    ' added 6/8/22 For sync  cwm  
    S1=S1.Replace ("#", Chr(156))        ' added 1/5/23 For sync  cwm # truncated the data  
    S1=S1.Replace ("\", Chr(157))        ' added 11/24/23 For sync  cwm '\' was dropped out of sync record  
    S1=S1.Replace (Chr(9), Chr(158))    ' added 11/24/23 For sync  cwm chr(9) was dropped out of sync record  
    S1=S1.Replace ("+", Chr(159))        ' added 11/24/23 For sync  cwm '+' was changed to a blank  
    S1=S1.Replace ("/", Chr(160))        ' added 11/24/23 For sync  cwm  
    S1=S1.Replace ("|", Chr(148))        ' added 11/25/23 For sync  cwm php doc warned of this char  
    S1=S1.Replace ("<", Chr(147))        ' added 11/25/23 For sync  cwm php doc warned of this char-inserted garbage  
    S1=S1.Replace (">", Chr(146))        ' added 11/25/23 For sync  cwm php doc warned of this char-inserted garbage  
    S1=S1.Replace ("^", Chr(145))        ' added 11/25/23 For sync  cwm php doc warned of this char-dropped char behind it in some cases  
    S1=S1.Replace ("%", Chr(144)) ' added 11/25/23 For sync cwm % has special meaning in html, ex: %20 is a space  
  
    Return S1  
End Sub  
  
Public Sub UnPurgeChar (S1 As String) As String  
    ' sub to rebuild single and double quotes  added 1/30/20 cwm  
    S1=S1.replace (Chr(149), "'"    )        ' single quote  
    S1=S1.Replace (Chr(150),Chr(34))        ' double quote  
    S1=S1.Replace (Chr(151),"&")            ' &  
    S1=S1.Replace (Chr(152),Chr(10))    ' added 6/8/22 For sync  cwm  
    S1=S1.Replace (Chr(155),Chr(13))    ' added 6/8/22 For sync  cwm  
    S1=S1.Replace (Chr(156),"#")        ' added 1/5/23 For sync  cwm  
    S1=S1.Replace (Chr(157), "\")        ' added 11/24/23 For sync  cwm '\' was dropped out of sync record  
    S1=S1.Replace (Chr(158), Chr(9))    ' added 11/24/23 For sync  cwm chr(9) was dropped out of sync record  
    S1=S1.Replace (Chr(159), "+")      ' added 11/24/23 For sync  cwm '+' was converted to a blank by the php     
    s1=s1.Replace (Chr(158), Chr(9))    ' added 11/24/23 For sync  cwm chr(9) was dropped out of sync record  
    S1=S1.Replace (Chr(160), "/")        ' added 11/24/23 For sync  cwm chr(9) was dropped out of sync record  
    S1=S1.Replace (Chr(148),"|")        ' added 11/25/23 For sync  cwm php doc warned of this char  
    S1=S1.Replace (Chr(147),"<")        ' added 11/25/23 For sync  cwm php doc warned of this char  
    S1=S1.Replace (Chr(146),">")        ' added 11/25/23 For sync  cwm php doc warned of this char  
    S1=S1.Replace (Chr(145),"^")        ' added 11/25/23 For sync  cwm php doc warned of this char  
    S1=S1.Replace (Chr(144), "%")        ' added 11/25/23 For sync  cwm % has special meaning in html, ex: %20 is a space  
  
    Return S1  
End Sub
```

  
  
**Steps to get the 'Test' environment up and running**  
  
1. Host  
 a. Sign up for a web-hosting site or use the one you have.  
 b. Follow the hosting site's steps to create a database with a password.  
 c. Don't bother setting up tables. They can be created easily in the PHP program.  
 d. Set up a folder structure as you wish but you might include a sub-folder for the PHP program.  
  
2. PHP program  
 a. Edit the attached TestPHP.txt program to your needs.  
 b. At minimum, you will need to update the 'open' of the database variables.  
 b. Rename it to TestPHP.PHP and upload it with your Host's upload facility.  
 c. From then on, I found it easiest to modify it on the host using their editor.  
 d. Save your final version back to your own pc.  
   
3. B4A test program  
 a. Unzip the TestPHP.B4A program and set it up in your C:\B4A folder. Bring up B4A and load it.  
 b. Modify the HTTPS URL to your own website and php folder.  
   
4. Bring up the test program and test.  
 a. Run the 'Build Table'. There is a note in the PHP program to allow you to 'Drop' the table if you need to change it. Be sure to 'comment' the commands again after you have re-run the 'build'.  
 b. Load several dummy records. Note that we are bumping up the record number after each send so you can identify the records when they come back in the 'read'.  
 c. Flag the records.  
 d. Receive the records flagged.  
 e You can add more records and flag them.  
 f. You can test the delete as well.  
   
5. If you really want to see it work, load the B4A program on a 2nd device. and read the records on the 2nd device.  
 You can then switch the from/to Ids on the 2nd device and send records back to the 1st device.  
 In this case, switch the 'from/to' ids on the 1st device so you can read those records.  
  
   
**Enhancements required for a full Sync Application**  
  
1. Buffered Inserts  
 In my early implementation, I attempted to send the records to the hosted database immediately following the update of records in the local DB.  
 When I used this logic with multiple records, I found the high speed of the internal DB updates was orders of magnitude faster than the send/receive to the hosted website.  
 If a return was in error or the internet connection was broken, I would have lost control of which records were sent successfully without a lot of logic and/or flags in the database.  
   
 Accordingly, I adopted the following process:  
 a. Set up a table in my local DB with an integer primary key and the command line string I am sending.  
 b. Insert a record into that table immediately after updating my primary tables. This includes any multiple records for multiple users. So if a record is sent to 3 users, 3 records are inserted, one to each 'ToId'.  
 c. Build a routine in Starter that is fired anytime the user returns to the B4XMainPage.  
 i. The routine reads each record in the table, sends it, and waits for the response. If ok, deletes the record using the primary key.  
 ii. If there is an 'Err1' or a loss of internet accessability, stop the process. It will start up the next time we return to B4XMainPage.  
  
2. Periodic 'Reads' for Sync records  
 The reading of records did not have the 'buffer'problem but I used a similar process:   
 a. Build a routine in Starter that could be fired to read records from the host.  
 i. The first step is to 'flag' any records for this 'ToId'.  
 ii. Then, read the records that are flagged. Parse them and update the local tables.  
 iii. Finally, delete the flagged records.  
 b. If at any point there is an error, 'Return' out of the process. The records will be read next time the routine is started.  
 c. The 'Read' could be started with a timer, but I have not found that to be required for my app.  
  
3. Unique record Ids for each device  
 a. A primary problem with sending records to another device is maintaining a key so that device A's record does not scrap over one of device B's records.  
 b. One solution is to set up a record key consisting of the device Id plus a sequence number. Thus, there can be an A-24 and a B-24. These records can be sent to the other device without scrapping over the other devices '24' record.  
 c. The next question is "Is is safe for A to update B's record and return it.  
 i. The simple solution is that you can only update and send your own records.  
 ii. In the right environment, where updates are infrequent, it might be safe for A to update B's record and return it.  
 iii. Another solution (my solution) would be to have each record be a 'minimal' stub which rarely needs updating (such as Date and Title) and then have another table of 'detail' records that can only be updated by the 'owner'.  
 In this example A might create a record and add a detail sub-record. Both are sent to B.  
 B receives both. B cannot update A's detail record but adds a detail record and returns it to A.  
 A can now see both detail records but cannot update B's.  
 The key for the detail record would be the key for the 'stub' record (A-24) plus an additional key with a different sequence number (A-120). B's detail record might look like A-24, B-45.  
  
  
**Observations on using PHP for traditional database storage on a remote host.**  
  
1. My application requires a database only for transient records, so query result size is generally small and not an issue.  
  
2. There may be an issue, however, if the PHP query yields thousands of records.  
 i. Because the records come back to B4A in one string and have to be parsed, the B4A program might break because of string size.  
 ii. Erel's JDRC2 appears to send the records back singly, but they may be parsed from a single string as in 'TestPHP.B4A'.  
 iii. If JDRC2 is sending back multiple single records, it can probably be done with PHP and I would be interested in any feedback regarding this.  
  
3. Table design in the hosted database  
 i. In the Sync application, we have sent records as a concatanation of the individual fields defined for the table. They are stored as a single table field on the hosted database. These records are then parsed on the receiving device and the local table updated.  
 ii. In a traditional database application you might want the individual fields defined so that you can perform selection on any of the fields.  
 iii. In this case you might still want to concatanate the record when sent, parse it in PHP, and update the individual fields in the table record on the remote host.  
 iv. The select command would then perform the record selection, concatonate the table fields, and return the record(s).  
 v. The receiving device would then parse the fields for display and possible update.  
  
4. Deleting Records.  
 The easiest approach would be to add a command for delete with the key(s) for the record passed.  
  
  
11/26/2023  
 In attempting to encrypt selected fields in our records we found some special characters caused drop-outs or insertion of extra characters in the messages sent to and from the server. See above for the new 'PurgeChar' and 'UnpurgeChar' subs that replace these special characters. The zip file below includes the updated routines.