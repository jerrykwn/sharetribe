require 'rocketchat'
#require_relative 'myrequest_helper'
module RocketChat
  module MyrequestHelper
    def request_json(path, options = {})
      path = if(server.path.to_s.empty?)
        path
        else 
        server.path + "/" + path
        end
      fail_unless_ok = options.delete :fail_unless_ok
      upstreamed_errors = Array(options.delete(:upstreamed_errors))

      response = request path, options
      check_response response, fail_unless_ok

      response_json = parse_response(response.body)
      options[:debug].puts("Response: #{response_json.inspect}") if options[:debug]
      check_response_json response_json, upstreamed_errors

      response_json
    end
  end  
class MyRocketClientRuby < Server
  include RocketChat::RequestHelper
  include RocketChat::MyrequestHelper
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
        '/api/v1/login',
        method: :post,
        body: {
          username: username,
          password: password
        }
      )
      Session.new self, Token.new(response['data'])
    end
    def info
      puts 'MyRocketClientRuby info'
      response = request_json '/api/v1/info', fail_unless_ok: true
      #response = request_json('/api/v1/info', debug: $stout)
      Info.new response['info']
    end

end

end

