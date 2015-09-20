class TreasureHuntController < ApplicationController
  #TOKEN = ENV['TOKEN']

  #before_action :authenticate, only: [:create]

  def create
    user_new_location = Position.new(params)
    if user_new_location.save
      distance_to_treasure_in_meters = Geocoder::Calculations.distance_between(user_new_location.current_position, Treasure.current_position) * 1000

      TreasureFoundMailer.treasure_found(user_new_location.user).deliver if distance_to_treasure_in_meters < 5
      render json: { status: 'ok', distance: distance_to_treasure_in_meters }
    else
      render json: { status: 'error', distance: -1, error: 'Something went wrong!' }
    end
  end

  private

  def user_location_params
    params.require(:current_position)
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == TOKEN
    end
  end
end
