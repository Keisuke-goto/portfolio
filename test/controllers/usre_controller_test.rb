require "test_helper"

class UsreControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get usre_create_url
    assert_response :success
  end
end
