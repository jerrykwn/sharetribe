#!/usr/bin/ruby -w
require 'rocketchat'

class RocketClient
  SERVERURL = 'http://127.0.0.1:3000'
  ADMIN='jerrykwn'
  def initialize()
    @userName, @password, @serverUrl= ADMIN, "Have78002003", SERVERURL
  end

  def initialize(serverUrl)
    @userName, @password, @serverUrl= ADMIN, "Have78002003", serverUrl
  end


  def initialize(username, password, serverUrl)
    @userName, @password, @serverUrl= username, password, serverUrl
    ##@session=nil
  end
  
  def getUserName
    @userName
  end  
  
  def getPassword
    @password
  end
  
  def setUserName(value)
    @userName = value
  end
  
  def setPassword(value)
    @password = value
  end
  
  def getServerUrl
    @serverUrl
  end
  
  def setServerUrl(value)
    @serverUrl = value
  end
  
  def getSession
    @session
  end
  
  def to_s
    "userName:#@userName, serverUrl:#@serverUrl"
  end
  
  private :getPassword, :getServerUrl
  
  def login   
    begin
      rocket_server = RocketChat::Server.new(@serverUrl, debug: $sterr)
      @session = rocket_server.login(@userName, @password)
      true
    rescue
      false
    end
    #puts @@session.to_s()
    # ... use the API ...
    #session.logout
  end
  
  def getUserList
    if (@session)
      users = @@session.users.list()
    else
      puts  "not login yet"
    end
  end
  
  def createUser(userName, email, name, password)
    if !@session
      isLogin = self.login()
      puts isLogin
    end
    
    puts @session.to_s()
    
    user = @session.users.create(userName, email, name, password, active: true, send_welcome_email: false)
    token =@session.users.create_token(user_id: user.id)
    puts token.data.to_s()
    true
  end
  
  def logout
    @session.logout()
    @session = nil
  end

  def self.finalize(bar)
    if (@session)
      @session.logout()
      @session = nil
      proc { puts "DESTROY OBJECT #{bar}" }
    end
  end
  
  
  def getSession
    @session
  end
end