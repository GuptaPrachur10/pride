class RidersController < ApplicationController
  before_action :logged_in_rider, only: [:show, :edit, :update]
  before_action :correct_rider,   only: [:show, :edit, :update]

  def show
    @rider = Rider.find(params[:id])
    @route = Route.find_by(rider_id: @rider.id)
    if @route.nil?
      @route = Route.new
    elsif 
      @recommendations = Ride.where("date BETWEEN ? AND ?", @route.date - 21600, @route.date + 21600)
      @recommendations = match(@recommendations,@route)
      @count = @recommendations.count
      @recommendations = @recommendations.paginate(page: params[:page], :per_page => 5)
    end
  end

  def new
    @rider = Rider.new
  end

  def create
    @rider = Rider.new(rider_params)    
    if @rider.save
      rider_login @rider
      flash[:success] = "Cheers Rider! Welcome to P-Ride :)"    	
      redirect_to @rider
    else
      render 'new'
    end
  end

  def edit
    @rider = Rider.find(params[:id])
  end

  def update
    @rider = Rider.find(params[:id])
    if @rider.update_attributes(rider_params)
      flash[:success] = "Successfully Updated!"
      redirect_to @rider
    else
      render 'edit'
    end
  end  

  private

    def rider_params
       params.require(:rider).permit(:name, :email, :mobile, :password,
                                   :password_confirmation)
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

    def match(relevant,route)
      res = []
      relevant.each do |item|
        if route.to_city == item.to_city && route.from_city == item.from_city
          res.push([item,(item.price * item.distance).round(-1)])
        end
      end
      return res
    end
end
