require "test_helper"

class TreasureHuntControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("treasure")
  end

  test "create should response 200 if everything is fine" do
    post :create, email: 'test@treasure.com', current_position: Treasure.current_position, format: :json

    assert_response 200
  end

  test "create should response 422 if something is wrong" do
    post :create, email: 'treasure.com', format: :json

    assert_response 422
  end

  test "create without http auth returns 401" do
    request.env['HTTP_AUTHORIZATION'] = ''
    post :create, email: 'test@treasure.com', current_position: Treasure.current_position, format: :json

    assert_response 401
  end
end
