require 'error/error.rb'

class Api::RidesController < Api::BaseController
  include ErrorHandling
  respond_to :json
  before_action :authenticate

  def index
    suitable_rides = Ride.within(0.5, :origin => [params[:start_point_lat], params[:start_point_lng]])
    available_rides = suitable_rides.where("nr_passengers < ?",  4)

    rides = available_rides.map do |ride|
      driver = Driver.find(ride.driver_id)
      {
        id:              ride.id,
        nr_passengers:   ride.nr_passengers,
        start_point_lat: ride.start_point_lat,
        start_point_lng: ride.start_point_lng,
        end_point_lat:   ride.end_point_lat,
        end_point_lng:   ride.end_point_lng,
        time:            ride.time,
        driver_name:     driver.name,
        driver_rating:   driver.rating / 100.0
      }
    end

    render json: {
      rides: rides
    }
  end

  def create
    if @current_user.rides.create(ride_params.merge(nr_passengers: 1))
      render json: {response: true}, status: :created
    else
      head(:unprocessable_entity)
    end
  end

  def accept_ride
    ride = Ride.find(params[:id])
    ride.update_attributes(nr_passengers: ride.nr_passengers + 1)
    if ride.users << @current_user
      render json: {response: true}, status: :created
    else
      head(:unprocessable_entity)
    end
  end

  private

  def ride_params
    params.permit(:driver_id, :start_point_lng, :start_point_lat, :end_point_lng, :end_point_lat, :time)
  end
end