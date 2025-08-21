<?php
$servername = "127.0.0.1";
$dbname = "phplogin";
$username ="root";
$password = "usioloeso123";
$action = $_GET["action"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
 } 

switch ($action) 
{
	case "registeruser":
		$username = $_GET["username"];
		$userpassword = $_GET["userpassword"];
		$sql = "INSERT INTO users";
		$sql = $sql . " (username,userpassword) VALUES";
		$sql = $sql . " ('$username','$userpassword')";
		$result = $conn->query($sql);
		// get last inserted auto increment value
		$last_id = $conn->insert_id;
		$sql = "SELECT * FROM users";
		$sql = $sql . " WHERE id = $last_id";
		$result = $conn->query($sql);
		$rows = array();
		while ($row = $result->fetch_assoc()) {
			$rows[] = $row;
		}
		print json_encode($rows);
		break;
	case "checkusername":
		// check user name existence
		$uname = $_GET["username"];
		$sql = "SELECT id FROM users WHERE username = '" . $uname . "';";
		$result = $conn->query($sql);
		$rows = array();
		while ($row = $result->fetch_assoc()) {
			$rows[] = $row;
		}
		print json_encode($rows);
		break;
	case "getuserids":
		$sql = "SELECT id FROM users;";
		$result = $conn->query($sql);
		$rows = array();
		while ($row = $result->fetch_assoc()) {
			$rows[] = $row;
		}
		print json_encode($rows);
		break;			
	case "search":
		$username = $_GET["username"];
		$sql = "select * from users where username like '%" . $username . "%' order by username";
		$result = $conn->query($sql);
		$rows = array();
		while ($row = $result->fetch_assoc()) {
			$rows[] = $row;
		}
		print json_encode($rows);
		break;
	case "checkemail":
		// check if user email exists for registration
		$email = $_GET["email"];
		$sql = "SELECT id,userpassword,username FROM tgif_users WHERE email = '" . $email . "';";
		$result = $conn->query($sql);
		$rows = array();
		while ($row = $result->fetch_assoc()) {
			$rows[] = $row;
		}
		print json_encode($rows);
		break;
	case "validateuser":
		// check if email address and password combination exists on database
		$username = $_GET["username"];
		$pwd = $_GET["userpassword"];
		$sql = "SELECT * FROM users WHERE username = '" . $username . "' AND userpassword = '" . $pwd . "';";
		$result = $conn->query($sql);
		$rows = array();
		while ($row = $result->fetch_assoc()) {
			$rows[] = $row;
		}
		print json_encode($rows);
		break;
	case "getall":
		$sql = "select * from users order by username";
		$result = $conn->query($sql);
		$rows = array();
		while ($row = $result->fetch_assoc()) {
			$rows[] = $row;
		}
		print json_encode($rows);
		break;
	case "updatepassword":
		// update the user profile
		$username = $_GET["username"];
		$userpassword = $_GET["userpassword"];
		$sql = "UPDATE users SET ";
		$sql = $sql . "userpassword='$userpassword'";
		$sql = $sql . " WHERE username = '$username'";
		$result = $conn->query($sql);
		$sql = "SELECT * FROM users WHERE username = '$username'";
		$result = $conn->query($sql);
		$rows = array();
		while ($row = $result->fetch_assoc()) {
			$rows[] = $row;
		}
		print json_encode($rows);
		break;
}
$conn->close();
?>
