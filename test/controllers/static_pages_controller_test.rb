require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get error" do
    get static_pages_error_url
    assert_response :success
  end

end
