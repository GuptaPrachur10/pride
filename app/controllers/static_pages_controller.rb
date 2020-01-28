class StaticPagesController < ApplicationController
  def home
  	if rider_logged_in?
  	  redirect_to current_rider
  	elsif driver_logged_in?
  	  redirect_to current_driver
  	end
  end

  def help
  end
end
