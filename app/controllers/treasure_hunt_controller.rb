class TreasureHuntController < ApplicationController
  # before_action :authenticate, only: [:create]

  def create
    new_user_location = Position.new(params)
    if new_user_location.save
      render json: { status: 'ok', distance: new_user_location.distance_to_treasure }
    else
      render json: { status: 'error', distance: -1, error: new_user_location.errors.inspect }
    end
  end

  def index
    positions = Position.all
    @hash = Gmaps4rails.build_markers(positions) do |position, marker|
      marker.lat position.latitude
      marker.lng position.longitude
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == ENV['TOKEN']
    end
  end
end
