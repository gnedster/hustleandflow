require 'test_helper'

class JudgesControllerTest < ActionController::TestCase
  setup do
    @judge = judges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:judges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create judge" do
    assert_difference('Judge.count') do
      post :create, judge: {  }
    end

    assert_redirected_to judge_path(assigns(:judge))
  end

  test "should show judge" do
    get :show, id: @judge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @judge
    assert_response :success
  end

  test "should update judge" do
    put :update, id: @judge, judge: {  }
    assert_redirected_to judge_path(assigns(:judge))
  end

  test "should destroy judge" do
    assert_difference('Judge.count', -1) do
      delete :destroy, id: @judge
    end

    assert_redirected_to judges_path
  end
end
