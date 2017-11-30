
#require_relative 'RocketClient'
require_relative 'User'

user = User.new("user7", "password", "user7@test.com")
puts user.to_s()
isLogin = user.login()
if isLogin
  puts 'Login'
else
  puts 'Failed to login'
end

# /*
# rc = RocketClient.new("jerrykwn", "Have78002003", "http://10.42.33.38:3000")
# rc.login()
# puts rc.getUserList().inspect
# puts rc.to_s()
# */
