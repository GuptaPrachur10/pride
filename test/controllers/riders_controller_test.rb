require 'test_helper'

class RidersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get riders_new_url
    assert_response :success
  end

end
