<?php
    require 'db.php';
    try
    {
        if (!isset($_GET['user_id']) || empty($_GET['user_id']) || 
            !isset($_GET['password']) || empty($_GET['password']))
        {
            print json_encode("Parameter Error");
            exit;
        }        
        $uid = $mysqli->escape_string($_GET["user_id"]);
        $pwd = $mysqli->escape_string($_GET["password"]);

        $sql = "SELECT user_name, reg_status";
        $sql .= " FROM tbl_member";
        $sql .= " WHERE user_id = '".$uid."'";
        $sql .= " AND pass_word = '".$pwd."'";
        $result = $mysqli->query($sql);
        if ($mysqli->errno)
        {
            print json_encode("Error");
            echo "<br />".$mysqli->error;
            exit;
        }
        else
        {
            if ($result->num_rows == 0)
            {
                print json_encode("Not Found");
                exit;
            }
            $row = $result->fetch_row();
            if ($row[1] == "M")
            {
                print json_encode("Not Activated");
            }
            else
            {
                print json_encode($row[0]);
                $sql = "UPDATE tbl_member";
                $sql .= " SET Online = 'N'";
                $sql .= " WHERE now()-time_stamp > 60";            
                $mysqli->query($sql);
                $sql = "UPDATE tbl_member";
                $sql .= " SET logins = logins + 1,";
                $sql .= " Online = 'Y',";
                $sql .= " time_stamp = now()";
                $sql .= " WHERE user_id = '$uid'";
                $mysqli->query($sql);
            }
        }
    }
    catch (Exception $e)
    {
        print json_encode("Failed");
        echo '<br />Caught exception: '.$e->getMessage()."\n";
    }    
?>