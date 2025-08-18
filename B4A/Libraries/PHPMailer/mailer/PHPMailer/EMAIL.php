<?php
// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

// Load Composer's autoloader
//require 'vendor/autoload.php';
require 'Exception.php';
require 'PHPMailer.php';
require 'SMTP.php';

function send_mail($from,$fromName,$to,$replyTo,$cc,$bc,$subject,$body,$attachments){
	// Instantiation and passing `true` enables exceptions
	$mail = new PHPMailer(true);

	try {
		//Server settings
		$mail->SMTPDebug = 1;                      // Enable verbose debug output
		$mail->isSMTP();                                            // Send using SMTP
		$mail->Host       = 'techheroghana.com';                    // Set the SMTP server to send through
		$mail->SMTPAuth   = true;                                   // Enable SMTP authentication
		$mail->Username   = 'info@techheroghana.com';                     // SMTP username
		$mail->Password   = 'g?P3nn35';                               // SMTP password
		$mail->SMTPSecure = 'PHPMailer::ENCRYPTION_STARTTLS ';         // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
		$mail->Port       = 587;                                    // TCP port to connect to, use 465 for `PHPMailer::ENCRYPTION_SMTPS` above

		//Recipients
		$mail->setFrom($from, $fromName);
		foreach($to as $email => $name)
		{
			$mail->addAddress($email, $name);// Add a recipient
		}
		if($replyTo !== null){	
			foreach($replyTo as $email)
			{
				$mail->addReplyTo($email);// Add Reply To
			}
		}
		if($cc !== null){	
			foreach($cc as $email)
			{
				$mail->addCC($email);// Add CC
			}
		}
		if($bc !== null){	
			foreach($bc as $email)
			{
				$mail->addBCC($email);// Add BCC
			}
		}
		if($attachments !== null){	
			foreach($attachments as $file => $name)
			{
				$mail->addBCC($email);// Add BCC
				$mail->addAttachment($file,$name);
			}
		}

		// Content
		$mail->isHTML(true);                                  // Set email format to HTML
		$mail->Subject = $subject;
		$mail->Body    = $body;
		$mail->AltBody = $body;

		$mail->send();
		return true;
	} catch (Exception $e) {
		return false;//"Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
	}
}

?>