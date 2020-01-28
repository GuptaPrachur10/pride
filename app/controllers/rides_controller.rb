class RidesController < ApplicationController

  before_action :logged_in_driver, only: [:show, :edit, :update]
  before_action :correct_driver,   only: [:show, :edit, :update]

  def new
    @ride = Ride.new
  end

  $message=''
  $from_city=''
  $to_city=''
  $distance=0.0

  def create
    @driver = current_driver
    if Ride.find_by(driver_id: @driver.id)
      update(ride_params)
    else
  	  @ride = Ride.new(ride_params)    # Not the final implementation!
      @ride.driver_id = current_driver.id
      if @ride.valid?
        if @ride.date > (Time.now + 1800) && @ride.date < (Time.now + (30*24*3600))
          if valid_address?(@ride)
            @ride.from_city = $from_city
            @ride.to_city = $to_city
            @ride.distance = $distance
            @ride.save
            redirect_to request.referrer
            flash[:success] = "Request Submitted!"
          else
            redirect_to request.referrer
            flash[:danger] = $message+" Please review and resubmit! (Try submitting a particular Landmark Point to avoid conflicts)"
          end  
        else
          redirect_to request.referrer
          flash[:danger] = "Invalid Date (Only 30 minutes to 30 days from now). Please review and resubmit!"
        end
      else
        redirect_to request.referrer
        if @ride.from.length == 0 || @ride.to.length == 0
          flash[:danger] = "Address empty. Please review and resubmit!"
        else
          flash[:danger] = "Address too long. Please review and resubmit!"
        end
      end
    end
  end

  def update
    existing = Relationship.where(driver_id:current_driver.id)
    existing.each do |item|
      item.destroy
    end
    @driver = current_driver
    @ride = Ride.new(ride_params)    # Not the final implementation!
    @ride.driver_id = current_driver.id
    if @ride.valid?
      if @ride.date > (Time.now + 1800) && @ride.date < (Time.now + (30*24*3600))
        if valid_address?(@ride)
          Ride.find_by(driver_id: @driver.id).update_attributes(ride_params)
          Ride.find_by(driver_id: @driver.id).update_attributes(from_city:$from_city,to_city:$to_city,distance:$distance)
          redirect_to request.referrer
          flash[:success] = "Request Submitted!"
        else
          redirect_to request.referrer
          flash[:danger] = $message+" Please review and resubmit! (Try submitting a particular Landmark Point to avoid conflicts)"
        end  
      else
        redirect_to request.referrer
        flash[:danger] = "Invalid Date (Only 30 minutes to 30 days from now). Please review and resubmit!"
      end
    else
      redirect_to request.referrer
      if @ride.from.length == 0 || @ride.to.length == 0
        flash[:danger] = "Address empty. Please review and resubmit!"
      else
        flash[:danger] = "Address too long. Please review and resubmit!"
      end
    end
  end 

  private

    def ride_params
       params.require(:ride).permit(:from, :to, :date, :price)
    end

    def valid_address?(address)
      begin 
        Geocoder.configure(:timeout => 10)
        arr = ["Andaman and Nicobar Islands","Lakshadweep"]
        gf = Geocoder.search(address.from)
        gt = Geocoder.search(address.to)
        if gf.length == 0 || gt.length == 0
          $message = "Address not recognised."
          return false
        elsif gf.first.country != "India" || gt.first.country != "India"
          $message = "Address out of India. We only serve in India right now."
          return false
        elsif gf.first.city.nil? || gt.first.city.nil?
          $message = "City not Recognised."
          return false
        elsif gf.first.city == gt.first.city
          $message = "Cities cannot be same."
          return false
        elsif arr.include?(gf.first.state) || arr.include?(gf.first.state_district) ||  arr.include?(gt.first.state) || arr.include?(gt.first.state_district) 
          $message = "We don't serve in these Areas."
          return false
        else
          $from_city = gf.first.city
          $to_city = gt.first.city
          $distance = Geocoder::Calculations.distance_between(Geocoder.coordinates($from_city),Geocoder.coordinates($to_city))
          return true
        end
      rescue
        return false
      end
    end

    def logged_in_driver
      unless driver_logged_in?
        flash[:danger] = "Please Login!"
        redirect_to driver_login_url
      end
    end

    def correct_driver
      @driver = Driver.find(params[:id])
      redirect_to(root_url) unless current_driver?(@driver)
    end

end
