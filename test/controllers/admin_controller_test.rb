require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:admin)
    @user_attributes = FactoryGirl.attributes_for(:admin)
  end

  test "should get upload" do
    login_user(@user)
    get :upload
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_redirected_to :login
  end

  test "should get album" do
    login_user(@user)
    get :album
    assert_response :success
  end
end
