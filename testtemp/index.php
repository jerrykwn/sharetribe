<?php

// in our app, this loads the configs/autoloader/etc
//require_once '../../rts_main.php';
require_once('UserBased.php');
require_once('User.php');
//header('Access-Control-Allow-Origin: '.$_SERVER['HTTP_ORIGIN']);
header('Access-Control-Allow-Credentials: true');
header('Content-Type: application/json');
try {
    // \Cmn\User::Current() pulls the user from our app
    //if(\Cmn\User::Current() === null) {
      //  throw new \Exceptions\Authorization("You are not authorized to see this!");
    //}
    //$me = new \Cmn\Chat\Rocket\UserBased();
    //$me->Login(\Cmn\User::Current());
	//$me = new UserBased();
	//$me->Login(new User());
    // Opted to just echo json directly rather than build an array and json_encode it. 
    //echo "{\n \"userId\":\"{$me->UserID()}\", \"loginToken\":\"{$me->Token()}\", \"token\":\"{$me->Token()}\" \n}";
	echo "{\n \"userId\":\"GeeBoTQLN5pNWZxHy\", \"loginToken\":\"kIYSh15J5AgM6-MksOeYVG4xp-3e-8V-Ha8G-nGIHZD\", \"token\":\"kIYSh15J5AgM6-MksOeYVG4xp-3e-8V-Ha8G-nGIHZD\" \n}";
}catch(\Exception $ex) {
    \Command\Log::Record($ex);
    header('HTTP/1.0 401 Not logged in.');
}
