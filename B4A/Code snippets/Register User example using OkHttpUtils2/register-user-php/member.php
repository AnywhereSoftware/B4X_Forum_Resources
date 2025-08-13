<?php
    require 'db.php';
    try
    {    
		$sql = "SELECT user_id, location, online";
		$sql .= " FROM tbl_member";
		$sql .= " ORDER BY id DESC";
		$result = $mysqli->query($sql);
		if ($mysqli->errno)
		{
    		header("HTTP/1.1 500 Internal Server Error");
    		echo $sql.'\n';
    		echo $mysqli->error;
		}
		else
		{
    		$rows = array();
    		while ($row = $result->fetch_assoc()) 
    		{
        		$rows[] = $row;
    		}
    		print json_encode($rows);
		}
	}
    catch (Exception $e)
    {
        print json_encode("Failed");
        echo '<br />Caught exception: '.$e->getMessage()."\n";
    }	
?>