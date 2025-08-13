<?php
header("Access-Control-Allow-Origin: *");
set_time_limit(0);
$resp = array();
$resp['fullpath'] = "";
$resp['status'] = "error";

if (isset($_FILES['upload'])) {
    // get the target
    $target = $_POST['target'];
    //does the target exist, if not create it
    $target_exists = is_dir($target);
    if (!$target_exists) {
        //create it
        mkdir($target, 0700, true);
    }
    $renameit = $_POST['renameit'];
    $myname = $_POST['myname'];
    //get the source file
    $source = $_FILES["upload"]["tmp_name"];

    if ($renameit == 'y') {
        $filename = uniqid() . "-" . time();
        $extension = pathinfo( $_FILES["upload"]["name"], PATHINFO_EXTENSION ); 
        $basename = $filename . "." . $extension; 
        $destination = $target . "/" . $basename;
        //the new file name is specified
        if (isset($myname)) {
            $destination = $target . "/" . $myname;
            $basename = $myname;
        }
        $moved = move_uploaded_file( $source, $destination );
        $resp['fullpath'] = $destination;
        $resp['name'] = $basename;
        if ($moved == true) {
            $resp['status'] = "success";
        }         
    } else {
        $destination = $target . "/" . $_FILES['upload']['name'];
        $moved = move_uploaded_file( $source, $destination );
        $resp['fullpath'] = $destination;
        $resp['name'] = $_FILES['upload']['name'];
        if ($moved == true) {
            $resp['status'] = "success";
        }         
    };
    $output = json_encode($resp);
    die($output);
    exit;
} else {
    $output = json_encode($resp);
    echo $output;
}
?>