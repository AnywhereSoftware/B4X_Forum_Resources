<?php
    require 'db.php';
    try
    {
        if(!isset($_GET['Action']) || empty($_GET['Action']))
        {
            print json_encode("Parameter Error");
            exit;
        }        
        $action = $mysqli->escape_string($_GET["Action"]);

        switch ($action)
        {
            case "Register":
                if (!isset($_GET['UserID']) || empty($_GET['UserID']) || 
                    !isset($_GET['Email']) || empty($_GET['Email']) || 
                    !isset($_GET['Password']) || empty($_GET['Password']) || 
                    !isset($_GET['FullName']) || empty($_GET['FullName']) || 
                    !isset($_GET['Location']) || empty($_GET['Location']))
                {
                    print json_encode("Parameter Error");
                    exit;
                }
                $user = $mysqli->escape_string($_GET["UserID"]);
                $email = $mysqli->escape_string($_GET["Email"]);
                $password = $mysqli->escape_string($_GET["Password"]);
                $fullname = $mysqli->escape_string($_GET["FullName"]);
                $location = $mysqli->escape_string($_GET["Location"]);
                $sql = "SELECT * FROM tbl_member";
                $sql .= " WHERE email = '".$email."'";
                $sql .= " OR user_id = '".$user."'";
                $result = $mysqli->query($sql);
                $count = $result->num_rows;
                if ($count == 0)
                {
                    $randomnumber = mt_rand(111111, 999999);
                    $sql = "INSERT INTO tbl_member";
                    $sql .= " (user_id, user_name, pass_word,";
                    $sql .= " email, location,";
                    $sql .= " reg_status, reg_no, online)";
                    $sql .= " VALUES (";
                    $sql .= " '$user', '$fullname', '$password',";
                    $sql .= " '$email', '$location',";
                    $sql .= " 'M', $randomnumber, 'N')";
                    $mysqli->query($sql);
                    $to      = $email;
                    $subject = "B4A Register User Demo";
                    $message = "Hi ".$user.","."\r\n";
                    $message .= "Please click on this link to finish";
                    $message .= " the registration process:";
                    $message .= " ".$server."signup.php?Action=Mail";
                    $message .= "&Mail=".$email;
                    $message .= "&RegNo=".$randomnumber;
                    $message = wordwrap($message, 70, "\r\n");
                    $headers = "From: ".$sender."\r\n";
                    $headers .= "Reply-To: ".$sender."\r\n";
                    $headers .= "X-Mailer: PHP/".phpversion();

                    mail($to, $subject, $message, $headers);
                    // Notify me of new sign up
                    $to      = $admin;
                    $subject = "New member";
                    $message = "New member (".$user.") has signed up using our demo app.";
                    mail($to, $subject, $message, $headers);
                    print json_encode("Mail");
                }
                else
                    print json_encode("MailInUse");      
                break;
            case "Mail":
                if (!isset($_GET['RegNo']) || empty($_GET['RegNo']) || 
                    !isset($_GET['Mail']) || empty($_GET['Mail']))
                {
                    print json_encode("Parameter Error");
                    exit;
                }            
                $regno = $mysqli->escape_string($_GET["RegNo"]);
                $mail = $mysqli->escape_string($_GET["Mail"]);
                $sql = "SELECT *";
                $sql .= " FROM tbl_member";
                $sql .= " WHERE email = '$mail'";
                $sql .= " AND reg_no = $regno";
                $sql .= " AND reg_status = 'M'";
                $result = $mysqli->query($sql);
                $count = $result->num_rows;     
                if ($count == 0)
                {
                    print json_encode("This registration is not valid / email address is already registered");
                }
                else
                {
                    $sql = "UPDATE tbl_member";
                    $sql .= " SET reg_status = 'R'";
                    $sql .= " WHERE email = '$mail'";
                    $sql .= " AND reg_no = $regno";
                    $mysqli->query($sql);
                    echo("$mail is registered now :-)");
                    print json_encode("Success");
                }
                break;
            default:
                echo("Unauthorized action! Please use the app to register.");
        }
    }
    catch (Exception $e)
    {
        print json_encode("Failed");
        echo '<br />Caught exception: '.$e->getMessage()."\n";
    }       
?>