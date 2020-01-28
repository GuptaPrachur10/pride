class SessionsController < ApplicationController

  def new
  end

  def rider_create
    rider = Rider.find_by(email: params[:session][:email].downcase)
    if rider && rider.authenticate(params[:session][:password])
      rider_login rider
      redirect_to rider
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'rider_new'
    end
  end

  def driver_create
    driver = Driver.find_by(email: params[:session][:email].downcase)
    if driver && driver.authenticate(params[:session][:password])
      driver_login driver
      redirect_to driver
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'driver_new'
    end
  end  

  def rider_destroy
    rider_logout
    redirect_to root_url
  end

  def driver_destroy
    driver_logout
    redirect_to root_url
  end

end
