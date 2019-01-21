require 'test_helper'

class StaticsControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get statics_landing_url
    assert_response :success
  end

end
