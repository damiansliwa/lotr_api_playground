require "test_helper"

class Api::V1::RealmsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_realms_index_url
    assert_response :success
  end
end
