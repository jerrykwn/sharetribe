class TempController < ApplicationController
	def show
		render template: "temp/#{params[:page]}"
  	end
end
