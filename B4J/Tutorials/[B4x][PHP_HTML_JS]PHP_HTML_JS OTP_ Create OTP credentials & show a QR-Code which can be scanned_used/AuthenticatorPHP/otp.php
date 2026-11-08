<div id="otp" class="modal">
  
  <form class="modal-content animate" action="index.php" method="post">

    <div class="container">
		<h3>OTP-Two-Way Authentification</h3>
		
	 <?php
			
			$otp = hash_hmac('sha256', 'OTP: otp.php', '1234');
			$secret=GenerateRandomString(32);
			$user='B4xUser';
			$label="B4x-OTP";
			$issuer="B4x.com";
			$key=Base32Encode($secret);
			$QRString='otpauth://totp/' . $label  .':' . $user . '?secret=' . $key . '&issuer=' . $issuer; 
	 ?>
	 
	 <table id="otptable" style="width: 80%;">
		  <tr>
			<td><img name="qrcode"  id="qrcode"><h3><b>Please scan this QR-code with your authenticator app</b></h3></td>
			</td>
		  </tr>
	</table>	  	 
	  
	  <br>
	<table id="keytable" style="width: 40%;">
		 <tr>
			<td><b>Key:</b></td>
			<td><?php echo $key; ?></td>
		</tr>
		<tr>
			<td><b>User:</b></td>
			<td><?php echo $user; ?></td>
		</tr>
		<tr>
			<td><b>Label:</b></td>
			<td><?php echo $label; ?></td>
		</tr>
		<tr>
			<td><b>Issuer:</b></td>
			<td><?php echo $issuer; ?></td>
		</tr>
		<tr>
			<td><b>Type</b></td>
			<td>SHA1, OTP</td>
		</tr>
	</table>	

		<br><br>
	  
	  
	</div>
  </form>
	
</div>
<script src="qrcode/dist/qrious.js"></script>
<script>
  (function() {
	var $background = "#ffffff";
	var $backgroundAlpha = "1";
	var $foreground = "#000000";
	var $foregroundAlpha = "1";
	var $level = "L";
	var $padding = "Auto";
	var $size = 200;
	var $value = "<?php print($QRString); ?>";
	var qr = window.qr = new QRious({
	  element: document.getElementById('qrcode'),
	  size: $size,
	  value: $value
	});
  })();
</script>

<?php

function GenerateRandomString($length) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}

function Base32Encode($text)
{
	$chars = str_split($text);
    $binary = [];
    foreach ($chars as $character) {
        $data = unpack('H*', $character);
        $binary[] = base_convert($data[1], 16, 2);
		$binary[sizeof($binary)-1]=str_pad($binary[sizeof($binary)-1], 8, '0', STR_PAD_LEFT);
    }
	
	$complete=implode($binary);
	$reallength=strlen($complete);
	$to40=40-$reallength % 40;
	
//Fill to the next 40 bits
for($i=0;$i<$to40;$i++)	
	{
		$complete=$complete . '0';
	}

//Get 5 Bit Chunks
	
	$FiveChars = str_split($complete, 5);

//Build Blocks
	$Base32Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
	$Base32Pad = "=";
	$Base32String="";

	for($i=0;$i<sizeof($FiveChars);$i++)	
	{
		$chrnr=bindec($FiveChars[$i]);
		
		if($FiveChars[$i]=='00000' && $i*5>$reallength)
		{
			$Base32String=$Base32String . $Base32Pad;
		}
		else
		{
			$Base32String=$Base32String . $Base32Alphabet[$chrnr];
		}
	}
	return $Base32String;
}

?>
