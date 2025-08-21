<?php

$jsonstring = file_get_contents("php://input"); //get the string or whatever you send via poststring

$mymap = array();
$mymap=json_decode($jsonstring, true);

$name=$mymap["Name"];
$surname=$mymap["Surname"];
$yob=$mymap["YearOfBirth"];

//Just send back a simple string
print 'The name was ' . $name . ', with the surname  ' . $surname . ' and he/she was born in the year ' . $yob;

?>