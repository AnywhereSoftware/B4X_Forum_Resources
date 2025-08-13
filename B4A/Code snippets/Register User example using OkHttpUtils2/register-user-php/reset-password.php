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
            case "RequestPasswordReset":
                if(!isset($_GET['Mail']) || empty($_GET['Mail']))
                {
                    print json_encode("Parameter Error");
                    exit;
                }            
                $email = $mysqli->escape_string($_GET["Mail"]);
                $sql = "SELECT user_name";
                $sql .= " FROM tbl_member";
                $sql .= " WHERE email = '" . $email . "'";
                $result = $mysqli->query($sql);
                if ($mysqli->errno)
                {
                    print json_encode("MySQL_Error");
                    echo "<br />MySQL_Error: ".$mysqli->error;
                    exit;
                }
                $count = $result->num_rows;
                if ($count == 0)
                {
                    print json_encode("InvalidEmail");
                    exit;
                }
                else
                {
                    // Generate a random code and update to reg_no
                    $verify_code = mt_rand(100000, 999999);
                    $row = $result->fetch_row();
                    $username = $row[0];
                    $sql = "UPDATE tbl_member";
                    $sql .= " SET reg_no = '" . $verify_code . "'";
                    $sql .= " WHERE email = '" . $email . "'";
                    $mysqli->query($sql);
                    if ($mysqli->errno)
                    {
                        print json_encode("MySQL_Error");
                        echo "<br />MySQL_Error: ".$mysqli->error;
                        exit;
                    }
                    // Send email to user to confirm the reset
                    $to      = $email;
                    $subject = 'Request to reset your password';
                    $message = "Hi " . $username . ",\r\n";
                    $message .= "We have received a request from you to reset your password.\r\n";
                    $message .= "If this action is not requested by you,";
                    $message .= " please ignore this email.\r\n";
                    $message .= "Otherwise, click the link below:\r\n";
                    $message .= $server."reset-password.php?Action=ConfirmPasswordReset";
                    $message .= "&Mail=".$email;
                    $message .= "&Code=".$verify_code . "\r\n\r\n";
                    $message .= "If not working, please copy the link to your browser.\r\n\r\n";
                    $message .= "Regards,\r\n";
                    $message .= "Aeric";
                    $message = wordwrap($message, 70, "\r\n");
                    $headers = "From: ".$sender."\r\n";
                    $headers .= "Reply-To: ".$sender."\r\n";
                    $headers .= "X-Mailer: PHP/" . phpversion();
                    mail($to, $subject, $message, $headers);
                    print json_encode("ValidEmail");
                }
            break;
        case "ConfirmPasswordReset":
            if (!isset($_GET['Mail']) || empty($_GET['Mail']) || 
                !isset($_GET['Code']) || empty($_GET['Code']))
            {
                print json_encode("Parameter Error");
                exit;
            }
            $email = $mysqli->escape_string($_GET["Mail"]);
            $code = $mysqli->escape_string($_GET["Code"]);
            $sql = "SELECT user_name";
            $sql .= " FROM tbl_member";
            $sql .= " WHERE email = '" . $email . "'";
            $sql .= " AND reg_no = " . $code;
            $result = $mysqli->query($sql);
            if ($mysqli->errno)
            {
                print json_encode("MySQL_Error");
                echo "<br />MySQL_Error: ".$mysqli->error;
                exit;
            }
            $count = $result->num_rows;
            if ($count == 0)
            {
                print json_encode("InvalidEmailOrCode");
                exit;
            }
            // Generate a default password randomly (e.g. pw1234)
            // You may use other method to generate a more complex password with alphanumeric
            $rand_number = mt_rand(1000, 9999);
            $default = "pw" . $rand_number;
            $row = $result->fetch_row();
            $username = $row[0];
            $sql = "UPDATE tbl_member";
            $sql .= " SET pass_word = '" . $default . "'";
            $sql .= " WHERE email = '" . $email . "'";
            $mysqli->query($sql);
            if ($mysqli->errno)
            {
                print json_encode("MySQL_Error");
                echo "<br />MySQL_Error: ".$mysqli->error;
                exit;
            }
            $to      = $email;
            $subject = 'Your New Password';
            $message = "Hi ".$username.",\r\n";
            $message .= "Your password has been reset.";
            $message .= " Please use your new password to log in.\r\n";
            $message .= "Password: " . $default;
            $message = wordwrap($message, 70, "\r\n");
            $headers = "From: ".$sender."\r\n";
            $headers .= "Reply-To: ".$sender."\r\n";
            $headers .= "X-Mailer: PHP/" . phpversion();
            mail($to, $subject, $message, $headers);
            //print json_encode("PasswordChanged");
            echo "Your password has been reset.<br />Your new password is sent to $email.";
            break;
        default:
            echo("Unauthorized action! Please use the app to reset your password.");
        }
    }
    catch (Exception $e)
    {        
        print json_encode("Failed");
        echo '<br />Caught exception: '.$e->getMessage()."\n";
    }
?>