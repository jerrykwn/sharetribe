require 'rocketchat'

class RocketClientController < ApplicationController
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
    render :json => token.data
  end
  
  def show
    #render template: "rocket_client/#{params[:page]}"
    render "rocket_client/#{params[:page]}"
    #redirect_to :action => 'index'
  end
  
  def index
    
  end
    
end
