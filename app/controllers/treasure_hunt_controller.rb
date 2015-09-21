class TreasureHuntController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    user_new_location = Position.new(params)
    if user_new_location.save
      render json: { status: 'ok', distance: user_new_location.distance_to_treasure }
    else
      render json: { status: 'error', distance: -1, error: user_new_location.errors.inspect }
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == ENV['TOKEN']
    end
  end
end
