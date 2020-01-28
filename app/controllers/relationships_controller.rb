class RelationshipsController < ApplicationController

  def create
    if Relationship.find_by(rider_id:current_rider.id,status:1)
      flash[:danger]="Already accepted by another driver."
      redirect_to current_rider
    else
      driver = Driver.find_by(id:params[:driver_id])
      msg = "Hi #{driver.name}, you have got a new join request."
      msg = msg + "\n" + "Name: #{current_rider.name.upcase}"
      msg = msg + "\n" + "From: #{current_rider.route.from.upcase}"
      msg = msg + "\n" + "To: #{current_rider.route.to.upcase}"
      msg = msg + "\n" + "Time: #{current_rider.route.date.strftime("%d %b %Y %I:%M %p")}"
  	  r = Relationship.find_by(rider_id:current_rider.id,driver_id:params[:driver_id])
  	  if r.nil?
        Relationship.create(rider_id:current_rider.id,driver_id:params[:driver_id],status:0)
        redirect_to current_rider
        notify(msg,driver)
      else
        r.update_attributes(rider_id:current_rider.id,driver_id:params[:driver_id],status:0)	
        redirect_to current_rider
        notify(msg,driver)
      end
    end
  end

  def update
    if Relationship.find_by(rider_id:params[:rider_id],status:1)
      flash[:danger]="Already accepted by another driver."
      redirect_to current_driver
    else 
      rider = Rider.find_by(id:params[:rider_id])
      msg = "Hi #{rider.name}, #{current_driver.name} has accepted your request. Enjoy the Ride!"
    #msg = msg + "\n" + "Name: #{current_driver.name.upcase}"
    #msg = msg + "\n" + "From: #{current_driver.ride.from.upcase}"
    #msg = msg + "\n" + "To: #{current_driver.ride.to.upcase}"
    #msg = msg + "\n" + "Time: #{current_driver.ride.date.strftime("%d %b %Y %I:%M %p")}"
      relationship = Relationship.find_by(driver_id:current_driver.id,rider_id:params[:rider_id],status:0)
  	  relationship.update_attributes(status:1)
      relationship = Relationship.where(rider_id:params[:rider_id],status:0)
      relationship.each do |item|
        item.destroy
      end
  	  redirect_to current_driver
      notify(msg,rider)
    end
  end

  def destroy
    rider = Rider.find_by(id:params[:rider_id])
    msg = "Hi #{rider.name}, #{current_driver.name} has declined your request."
  	relationship = Relationship.find_by(driver_id:current_driver.id,rider_id:params[:rider_id],status:0)
  	relationship.update_attributes(status:2)
  	redirect_to current_driver
    notify(msg,rider)
  end

  private

    def notify(msg,user)
      client = Twilio::REST::Client.new
      client.messages.create(from:"whatsapp:+14155238886",body:msg, to:"whatsapp:+91#{user.mobile}")
    end
end

