require 'test_helper'

class FatsControllerTest < ActionController::TestCase
  setup do
    @fat = fats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fat" do
    assert_difference('Fat.count') do
      post :create, fat: { date: @fat.date, user_id: @fat.user_id, value: @fat.value }
    end

    assert_redirected_to fat_path(assigns(:fat))
  end

  test "should show fat" do
    get :show, id: @fat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fat
    assert_response :success
  end

  test "should update fat" do
    patch :update, id: @fat, fat: { date: @fat.date, user_id: @fat.user_id, value: @fat.value }
    assert_redirected_to fat_path(assigns(:fat))
  end

  test "should destroy fat" do
    assert_difference('Fat.count', -1) do
      delete :destroy, id: @fat
    end

    assert_redirected_to fats_path
  end
end
