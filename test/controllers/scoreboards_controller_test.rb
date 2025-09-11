require "test_helper"

class ScoreboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get scoreboards_index_url
    assert_response :success
  end
end
