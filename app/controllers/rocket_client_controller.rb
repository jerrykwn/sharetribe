require 'rocketchat'

class RocketClientController < ApplicationController
  before_action :cors_set_access_control_headers
  #layout false 
  puts "RocketClientController 1"
  before_action :only => [ :gettoken ] do |controller|
    controller.ensure_logged_in t("layouts.notifications.you_must_log_in_to_create_new_listing", :sign_up_link => view_context.link_to(t("layouts.notifications.create_one_here"), sign_up_path)).html_safe
  end
  puts "RocketClientController 2"
  include RocketClientHelper
  puts "RocketClientController 3"
  def gettoken
    puts "RocketClientController 4"
    rocketClinet = RocketClientHelper::RocketClient.new(RocketClientHelper::MY_ROCKETCHAT_SERVER)
    puts "RocketClientController 5"
    if !rocketClinet.login?(@current_user.given_name, "password" )
      puts "RocketClientController 6"
      person = Person.find(@current_user.id)
      puts person.inspect
      rocketClinet.createUser(@current_user.given_name, "user10@test.com", @current_user.username, "password" )
      puts "RocketClientController 7"
    end
    token = rocketClinet.getLoginToken();
    puts token.data.to_s()
    output = {'loginToken' => token.data['authToken'], 'userId' => token.data['userId'], 'token' => token.data['authToken'], 'Access-Control-Allow-Credentials' => 'http://localhost:3000'}.to_json
    render :json => output
    #render :json => token.data
  end
  
  def show
    #render template: "rocket_client/#{params[:page]}"
    render "rocket_client/#{params[:page]}"
    #redirect_to :action => 'index'
  end
  
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
    headers['Access-Control-Allow-Credentials'] = 'true'
  end
  
  def index
    
  end
    
end
