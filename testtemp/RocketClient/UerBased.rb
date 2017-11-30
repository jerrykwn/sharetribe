#!/usr/bin/ruby -w
require_relative  'RcoketClient'
require_relative  'User'
class UserBased < RocketClient
  private :@tocken, :@userId, :@cache
  
  def self.getAuth(userName, password)
    //
  end
  
  def getToken
    @tocken
  end
  
  def getUserId
    @userId
  end
  
  def getCache
    #
  end
  
  def getByUser(userName)
    getByPassword(userName)
  end
  
  def getByPassword(userName)
    login(userName)
  end
  
  def login(user)
    
  end
  
  def updateCache
    
  end
  
  def updateUser
    
  end
end