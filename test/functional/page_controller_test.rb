require 'test_helper'

class PageControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get support" do
    get :support
    assert_response :success
  end

  test "should get terms" do
    get :terms
    assert_response :success
  end

end
