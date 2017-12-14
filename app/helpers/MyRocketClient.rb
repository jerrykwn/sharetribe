require 'rocketchat'
module RocketChat
class MyRocketClientRuby < Server
  include RocketChat::RequestHelper
   #
    # Login REST API
    # @param [String] username Username
    # @param [String] password Password
    # @return [Session] Rocket.Chat Session
    # @raise [HTTPError, StatusError]
    #
    def login(username, password)
      puts 'MyRocketClientRuby login'
      response = request_json(
        '/api/login',
        method: :post,
        body: {
          username: username,
          password: password
        }
      )
      Session.new self, Token.new(response['data'])
    end
  
end

end

