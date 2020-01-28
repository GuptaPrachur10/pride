class RoutesController < ApplicationController

  before_action :logged_in_rider, only: [:show, :edit, :update]
  before_action :correct_rider,   only: [:show, :edit, :update]


  def new
    @route = Route.new
  end

  $message=''
  $from_city=''
  $to_city=''
  $distance=0.0

  def create
    @rider = current_rider
    if Route.find_by(rider_id: @rider.id)
      update(route_params)
    else
  	  @route = Route.new(route_params)    # Not the final implementation!
      @route.rider_id = current_rider.id
     if @route.valid?
        if @route.date > (Time.now + 1800) && @route.date < (Time.now + (30*24*3600))
          if valid_address?(@route)
            @route.from_city = $from_city
            @route.to_city = $to_city
            @route.distance = $distance
            @route.save
            redirect_to request.referrer
            flash[:success] = "Request submitted!"
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
        if @route.from.length == 0 || @route.to.length == 0
          flash[:danger] = "Address empty. Please review and resubmit!"
        else
          flash[:danger] = "Address too long. Please review and resubmit!"
        end
      end
    end
  end

  def update
    existing = Relationship.where(rider_id:current_rider.id)
    existing.each do |item|
      item.destroy
    end
    @rider = current_rider
    @route = Route.new(route_params)    # Not the final implementation!
    @route.rider_id = current_rider.id
     if @route.valid?
        if @route.date > (Time.now + 1800) && @route.date < (Time.now + (30*24*3600))
          if valid_address?(@route)
            Route.find_by(rider_id:@rider.id).update_attributes(route_params)
            Route.find_by(rider_id:@rider.id).update_attributes(from_city:$from_city,to_city:$to_city)
            redirect_to request.referrer
            flash[:success] = "Request submitted!"
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
        if @route.from.length == 0 || @route.to.length == 0
          flash[:danger] = "Address empty. Please review and resubmit!"
        else
          flash[:danger] = "Address too long. Please review and resubmit!"
        end
      end
  end 

  private

    def route_params
       params.require(:route).permit(:from, :to, :date)
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
          return true
        end
      rescue
        return false
      end
    end

    def logged_in_rider
      unless rider_logged_in?
        flash[:danger] = "Please Login!"
        redirect_to rider_login_url
      end
    end

    def correct_rider
      @rider = Rider.find(params[:id])
      redirect_to(root_url) unless current_rider?(@rider)
    end

end