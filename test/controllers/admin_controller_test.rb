require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:admin)
    @user_attributes = FactoryGirl.attributes_for(:admin)
  end

  test "should get index" do
    get :index
    assert_redirected_to :login
  end

end
