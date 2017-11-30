<?php

//namespace Cmn\Chat\Rocket;

/**
 * Description of Base
 *
 * @author jay
 */
require 'vendor/autoload.php';
class Base {
    /*const ROCKET_URI = 'http://your.rocket.chat.install';*/
	const ROCKET_URI = 'http://10.42.33.38:3000';
    protected $_client;
    protected $_headers;
    protected $_body;
    protected $_endPoint;
    public function __construct($endpoint = '/api/version', array $headers = null, array $body = null) {
        $this->_headers = $headers ? $headers : array();
        $this->_body = $body ? $body : array();
        $this->_endPoint = $endpoint;
        $this->_client = new \GuzzleHttp\Client();
    }
    public function Body() { return $this->_body; }
    public function AddBody($name, $value = null) {
        if(is_array($name)) {
            $this->_body = array_merge($this->_body, $name);
        } else {
            $this->_body[$name] = $value;
        }
        return $this;
    }
    public function EndPoint($endPoint = false) {
        if($endPoint) { 
            $this->_endPoint = $endPoint;
            return $this;
        }
        return $this->_endPoint;
    } 
    public function Headers() { return $this->_headers; }
    public function AddHeader($name, $value = null) {
        if(is_array($name)) {
            $this->_headers = array_merge($this->_headers, $name);
        } else {
            $this->_headers[$name] = $value;
        }
        return $this;
    }
    public function SendPost(array $headers = null, array $body = null) {
		echo "{\n SendPost \n}";
        $this->AddHeader('Content-Type', 'application/x-www-form-urlencoded');
        if($headers) { $this->AddHeader($headers); }
        if($body) { $this->AddBody($body); }
        $b = array();
        foreach($this->Body() as $name => $value) { $b[] = "{$name}={$value}"; }
        return json_decode($this->SendRequest('POST', $this->EndPoint(), array('headers' => $this->Headers(), 'body' => implode("&", $b))));
    }
    public function SendJSON(array $headers = null, array $body = null) {
        $this->AddHeader('Content-type', 'application/json');
        if($headers) { $this->AddHeader($headers); }
        if($body) { $this->AddBody($body); }
        return json_decode($this->SendRequest('POST', $this->EndPoint(), array('headers' => $this->Headers(), 'json' => $this->Body())));
    }
    public function SendRequest($method, $endpoint, $options) {
        /* @var $r \GuzzleHttp\Psr7\Response */
        $r = $this->_client->request($method, static::ROCKET_URI.$endpoint, $options);
        $t = $r->getBody();
        $buffer = "";
        while(!$t->eof()) {
            $buffer .= $t->read(4096);
        }
        return $buffer;
    }
}
?>