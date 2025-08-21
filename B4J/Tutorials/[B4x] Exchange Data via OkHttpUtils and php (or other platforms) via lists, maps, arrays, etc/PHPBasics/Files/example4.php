<?php

$rows = array();

$singlerow=array('Name' => 'Peter', 'Surname' => 'Smith', 'YearOfBirth' => '1970');
$rows[] = $singlerow;
$singlerow=array('Name' => 'Michael', 'Surname' => 'Jonson', 'YearOfBirth' => '1958');
$rows[] = $singlerow;

print json_encode($rows);

?>