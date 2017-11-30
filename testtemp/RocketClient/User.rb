require_relative 'RocketClient'

class User
  @rocketChatServerUrl = 'http://10.42.33.38:3000/'
  def initialize(username, password, email)
    @userName, @password, @email= username, password, email
  end
  
  def getUserName
    @userName
  end
  
  def getEmail
    @email
  end
  
  def setEmail(value)
    @email = value
  end
  
  def setUserName(value)
    @userName = value
  end
  
  def getRocketClient
    @rocketClient
  end
  
  def login
    puts 'hehehe'
    if !@rocketClient
       puts 'hehehe 1'
      @rocketClient = RocketClient.new(@userName, @password, 'http://10.42.33.38:3000/')
      puts @rocketClient.to_s()
      puts 'hehehe 2'
    end
    
    isLogin = @rocketClient.login();
    puts 'hehehe 3'
    if !isLogin
      puts 'hehehe 4'
      adminRocketClient =  RocketClient.new('jerrykwn', 'Have78002003', 'http://10.42.33.38:3000/')
      puts adminRocketClient.to_s()
      adminRocketClient.createUser(@userName, @email, @userName, @password)
      @rocketClient.login()
      puts 'hejhe'
    end
    
    channel = @rocketClient.getSession.channels.join(name: 'general')
    true
  end
  
  def logout
    @rocketClient.logout()
  end
  
  def to_s
    "userName:#@userName, emailAddress#@email"
  end   
end
