require 'rocketchat'

module RocketClientHelper
  MY_ROCKETCHAT_SERVER = 'http://127.0.0.1:3000'
  MY_ROCKETCHAT_ADMIN = 'jerrykwn'
  
  class RocketClient
    
    def initialize(serverUrl)
      @serverUrl = serverUrl
    end
    
    
    def login?(userName, userPassword)
      puts "come into login for #{userName}"
      begin
        rocket_server = RocketChat::Server.new(@serverUrl, debug: $sterr)
        @session = rocket_server.login(userName, userPassword)
        true
      rescue
        puts "did not login for #{userName}"
        false
      end
    end
     
    def createUser(userName, email, displayName, userPassword)
      puts "create user:#{userName}, email: #{email}, displayName: #{displayName} password: #{userPassword}"
      begin
        rocket_server = RocketChat::Server.new(@serverUrl, debug: $sterr)
        session = rocket_server.login(MY_ROCKETCHAT_ADMIN, 'Have78002003')
        user = session.users.create(userName, email, displayName, userPassword, active: true, send_welcome_email: false)
        session.logout()
        login?(userName, userPassword)
      rescue
        puts "Could not login chat"
      end
    end

    def getCurrentSession
      @session
    end
    
    def getLoginToken
      @session.token()
    end
      
    def logout
      @session.logout()
      @session = nil
    end      
     
    
    def self.finalize
      if @session
       @session.logout()
       @session = nil
      end
    end
  end
end
