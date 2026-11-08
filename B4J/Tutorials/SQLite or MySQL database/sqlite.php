<?php
function adminer_object() {
	include_once "plugin.php";
	include_once "login-password-less.php";
	
	class AdminerCustomization extends AdminerPlugin {
		function loginFormField($name, $heading, $value) {
			return parent::loginFormField($name, $heading, str_replace('value="server"', 'value="sqlite"', $value));
		}
		function database() {
			return "YOUR_DB_FILE_PATH_NAME";	//"/home/username/db.sqlite3";
		}
	}
	
	return new AdminerCustomization(array(
		// TODO: inline the result of password_hash() so that the password is not visible in source codes
		new AdminerLoginPasswordLess(password_hash("YOUR_ADMIN_PASSWORD_FOR_SQLITE_DB", PASSWORD_DEFAULT)),
	));
}

include "index.php";
