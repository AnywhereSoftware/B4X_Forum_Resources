<?php
    require 'db.php';
    try
    {
        if(!isset($_GET['user_id']) || empty($_GET['user_id']))
        {
            print json_encode("Parameter Error");
            exit;
        }        
        $uid = $mysqli->escape_string($_GET["user_id"]);
        $sql = "SELECT online";
        $sql .= " FROM tbl_member";
        $sql .= " WHERE user_id = '$uid'";
		$result = $mysqli->query($sql);
		$count = $result->num_rows;
		if ($count == 0)
		{
  			print json_encode("NotMember");
		}
		else
		{
			$sql = "UPDATE tbl_member";
			$sql .= " SET online = 'N'";
			$sql .= " WHERE user_id = '".$uid."'";
    		$mysqli->query($sql);
    		print json_encode("LoggedOut");
		}
	}
    catch (Exception $e)
    {
        print json_encode("Failed");
        echo '<br />Caught exception: '.$e->getMessage()."\n";
    }	
?>