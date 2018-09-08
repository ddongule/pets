require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get crawler" do
    get index_crawler_url
    assert_response :success
  end

end
