<?php
// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

// Load Composer's autoloader
//require 'vendor/autoload.php';
require 'PHPMailer/Exception.php';
require 'PHPMailer/PHPMailer.php';
require 'PHPMailer/SMTP.php';

function send_mail($from,$fromName,$to,$subject,$body){
	// Instantiation and passing `true` enables exceptions
	$mail = new PHPMailer(true);

	try {
		//Server settings
		$mail->SMTPDebug = 0;                      // Enable verbose debug output
		$mail->isSMTP();                                            // Send using SMTP
		$mail->Host       = '[host]';                    // Set the SMTP server to send through
		$mail->SMTPAuth   = true;                                   // Enable SMTP authentication
		$mail->Username   = '[host email]';                     // SMTP username
		$mail->Password   = '[host password]'; 
		$mail->SMTPSecure = 'PHPMailer::ENCRYPTION_STARTTLS ';         // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
		$mail->Port       = 587;                                    // TCP port to connect to, use 465 for `PHPMailer::ENCRYPTION_SMTPS` above

		//Recipients
		foreach($to as $email => $name)
		{
			$mail->addAddress($email, $name);
		}
		$mail->setFrom($from, $fromName);
		//$mail->addAddress($to);     // Add a recipient
		//$mail->addAddress('ellen@example.com');               // Name is optional
		//$mail->addReplyTo('info@example.com', 'Information');

		// Attachments
		//$mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
		//$mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name

		// Content
		$mail->isHTML(true);                                  // Set email format to HTML
		$mail->Subject = $subject;
		$mail->Body    = $body;
		$mail->AltBody = $body;

		$mail->send();
		return true;
	} catch (Exception $e) {
		echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
		return false;//"Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
	}
}

?>