require 'rocketchat'
require_relative 'MyRocketClient.rb'

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
    
    def createRoom(roomName)
      channel = @session.channels.create(roomName,
                     members: ['user1', 'user2'])
      puts channel.to_s()
    end
  end
end

=begin
    rocketClinet = RocketClientHelper::RocketClient.new(RocketClientHelper::MY_ROCKETCHAT_SERVER)
    puts "RocketClientController 5"
    if !rocketClinet.login?("user1", "password" )
      puts "RocketClientController 6"
      
      #person = Person.find(@current_user.id)
      #puts person.inspect
      rocketClinet.createUser("user1", "user1@test.com", "user1", "password" )
      puts "RocketClientController 7"
    end
    token = rocketClinet.getLoginToken();
    rocketClinet.createRoom("MyRoom")
    puts token.data.to_s()
    #render :json => token.data
=end