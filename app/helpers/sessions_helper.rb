module SessionsHelper

  def rider_login(rider)
    session[:rider_id] = rider.id
  end

  def driver_login(driver)
    session[:driver_id] = driver.id
  end

  def current_rider?(rider)
    rider == current_rider
  end

  def current_driver?(driver)
    driver == current_driver
  end

  def current_rider
    if session[:rider_id]
      @current_rider ||= Rider.find_by(id: session[:rider_id])
    end
  end

  def current_driver
    if session[:driver_id]
      @current_driver ||= Driver.find_by(id: session[:driver_id])
    end
  end

  def rider_logged_in?
    !current_rider.nil?
  end

  def driver_logged_in?
    !current_driver.nil?
  end

  def rider_logout
    session.delete(:rider_id)
    @current_rider = nil
  end

  def driver_logout
    session.delete(:driver_id)
    @current_driver = nil
  end

  def correct_rider
    @rider = Rider.find(params[:id])
    redirect_to(root_url) unless current_rider?(@rider)
  end

  def correct_driver
    @driver = Driver.find(params[:id])
    redirect_to(root_url) unless current_driver?(@driver)
  end

end
