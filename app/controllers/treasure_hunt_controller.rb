class TreasureHuntController < ApplicationController
  def create
    if user_new_location = UserLocation.create(user_location_params)
      distance_to_treasure = Geocoder::Calculations.distance_between(user_new_location.current_position, TreasureLocation.current_position, units: :meter)
      render status: 'ok', distance: distance_to_treasure
      # TODO: send email if distance_to_treasure is less than 5 meters
    else
      render status: 'error', distance: -1, error: 'Something went wrong!'
    end
  end

  def user_location_params
    params.require(:current_position, :email)
  end
end
