require "test_helper"

class TreasureHuntControllerTest < ActionController::TestCase
  test "create should response success if everything when fine" do
    post :create, email: 'test@treasure.com', current_position: Treasure.current_position, format: :json

    assert_response 200
  end

  test "create should response error if something went wrong" do
    post :create, email: 'treasure.com', format: :json

    assert_response 422
  end
end
