<?php
require 'db.php';
try
{
    if (!isset($_GET['Email']) || empty($_GET['Email']) || 
        !isset($_GET['Password1']) || empty($_GET['Password1']) || 
        !isset($_GET['Password2']) || empty($_GET['Password2']))
    {
        print json_encode("Parameter Error");
        exit;
    }
    $email = $mysqli->escape_string($_GET["Email"]);
    $password1 = $mysqli->escape_string($_GET["Password1"]);
    $password2 = $mysqli->escape_string($_GET["Password2"]);
    $sql = "SELECT * FROM tbl_member";
    $sql .= " WHERE email = '".$email."'";
    $sql .= " AND pass_word = '".$password1."'";
    $result = $mysqli->query($sql);
    $count = $result->num_rows;
    if ($count == 0)
    {        
        print json_encode("Not Found");
        echo("<br />User not found or incorrect password");
    }
    else
    {
        $sql = "UPDATE tbl_member";
        $sql .= " SET pass_word = '".$password2."'";
        $sql .= " WHERE email = '".$email."'";
        $sql .= " AND pass_word = '".$password1."'";
        $mysqli->query($sql);        
        print json_encode("Success");
        echo("<br />$email has been updated");
    }
}
catch (Exception $e)
{
    print json_encode("Failed");
    echo '<br />Caught exception: '.$e->getMessage()."\n";
}       
?>