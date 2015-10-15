require 'json'

class IosLoginController < ApplicationController
	def receive_login_data
        
        puts request.headers

		username = request.headers["Username"]
		password = request.headers["Password"]
		
		users = User.all
		user_id = 'None'
		users.each do |user|
		    if user.email == username && user.valid_password?(password)
		      user_id = user.id.to_s
		    end
		end
		
		render text: user_id

	end
end
