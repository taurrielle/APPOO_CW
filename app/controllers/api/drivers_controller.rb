require 'error/error.rb'

class Api::DriversController < Api::BaseController
  include ErrorHandling
  before_action :authenticate

  def index
    unavailable_drivers = []
    time = Time.parse(params[:time])
    rides = Ride.where('time between ? and ?', time, time + 30.minutes)
    rides.each do |ride|
      unavailable_drivers << Driver.find(ride.driver_id)
    end
    drivers = Driver.all - unavailable_drivers.uniq

    render json: {
      drivers: drivers.uniq
    }
  end

  def rate
    driver = Driver.find(params[:id])
    new_rating = (driver.rating + params[:rating] * 100) / 2.0
    if driver.update_attributes(rating: new_rating)
      render json: {response: true}, status: :accepted
    else
      head(:unprocessable_entity)
    end
  end

  private

  def ride_params
    params.permit(:driver_id, :start_point_lng, :start_point_lat, :end_point_lng, :end_point_lat, :time)
  end
end