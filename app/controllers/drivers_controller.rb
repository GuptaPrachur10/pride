class DriversController < ApplicationController
  before_action :logged_in_driver, only: [:show, :edit, :update]
  before_action :correct_driver,   only: [:show, :edit, :update]

  def show
    @driver = Driver.find(params[:id])
    @ride = Ride.find_by(driver_id: @driver.id) 
    if @ride.nil?
      @ride = Ride.new
    end
  end

  def new
    @driver = Driver.new 
  end

  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      driver_login @driver
      flash[:success] = "Cheers Driver! Welcome to P-Ride :)"
      redirect_to @driver
    else
      render 'new'
    end
  end

  def edit
    @driver = Driver.find(params[:id])
  end

  def update
    @driver = Driver.find(params[:id])
    if @driver.update_attributes(driver_params)
      flash[:success] = "Successfully Updated!"
      redirect_to @driver      
    else
      render 'edit'
    end
  end

  private

    def driver_params
       params.require(:driver).permit(:name, :email, :mobile, :password,
                                   :password_confirmation)
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
