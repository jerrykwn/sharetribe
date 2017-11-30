<?php

//namespace Cmn\Chat\Rocket;

/**
 * Description of UserBased
 *
 * @author jay
 */
require_once('Base.php');
require_once('User.php');
require_once('AuthCache.php');
class UserBased extends Base {
    protected $_token;
    protected $_userId;
    protected $_cache;
    public static function GetAuth($user, $password) {
		echo "{\n GetAuth \n}";
        try {
            $c = new Base("/api/login", null, array('user'=>$user, 'password'=>$password));
			echo "{\n GetAuth \n}";
            $r = $c->SendPost();
            return $r->data;
        } catch(\Exception $ex) {
            //\Command\Log::Record($ex);
            return (object)array('error'=>$ex);
        }
    }
    public function Token() { return $this->_token; }
    public function UserID() { return $this->_userId; }
    /**
     * 
     * @return AuthCache
     */
    public function Cache() { return $this->_cache; }
    /**
     * 
     * @param User $user
     * @return UserBased
     */
    public static function GetByUser(User $user) { return static::GetByPassword($user); }
    /**
     * 
     * @param User $user
     * @return UserBased
     */
    public static function GetByPassword(User $user) {
        $class = get_called_class();
        $c = new $class();
        return $c->Login($user);
    }
    public function Login(User $user, $refresh = false) {
        $this->GetCache($user);
		echo "{\n Login \n}";
		$this->UpdateCache($user);
        if($refresh || !$this->_cache) {
			echo "{\n Login 3\n}";
            $this->UpdateCache($user);
        }
		echo "{\n Login 2\n}";
        $this->_token = $this->_cache->rs_token;
        $this->_userId = $this->_cache->rs_userid;
		echo "{\n \"rs_token\":\"{$this->_token }\", \"rs_userid\":\"{$this->_userId}\" \n}";
        $this->AddHeader('X-Auth-Token', $this->_token);
        $this->AddHeader('X-User-Id', $this->_userId);
        return $this;
    }
    public function UpdateCache(User $user) {
		echo "{\n UpdateCache \n}";
        $auth = static::GetAuth($user->email, substr($user->password, 0, 17));
        if(isset($auth->error)) {
            return $this->_updateUser($user);
        }
				echo "{\n UpdateCache 2\n}";
        if(!$this->_cache) {
            $this->_cache = new AuthCache();
            $this->_cache->id = $user->email;
        }
        $this->_cache->rs_userid = $auth->userId;
        $this->_cache->rs_token  = $auth->authToken;
        $this->_cache->date_generated = date('Y-m-d H:i:s');
        return $this->_cache->Save();
    }
    public function GetCache(User $user) {
		echo "{\n GetCache \n}";
        if($this->_cache) { return $this->_cache; }
        try {
			echo "{\n GetCache 3\n}";
            $this->_cache = new AuthCache($user->email);
        } catch (\Exceptions\ItemNotFound $ex) {
            $this->_cache = null;
        }
		echo "{\n GetCache 2\n}";
        return $this->_cache;
    }
    protected function _updateUser(User $user) {
        //For now, we are going to assume the player doesn't exist
        $a = new \Cmn\Chat\Rocket\AdminBot();
        $a->CreateUser($user);
        return $this->UpdateCache($user);
        //throw new \Exceptions\NotImplemented();
    }
}
