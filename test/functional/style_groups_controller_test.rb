require 'test_helper'

class StyleGroupsControllerTest < ActionController::TestCase
  setup do
    @style_group = style_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:style_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create style_group" do
    assert_difference('StyleGroup.count') do
      post :create, style_group: { group_id: @style_group.group_id, music_style_id: @style_group.music_style_id }
    end

    assert_redirected_to style_group_path(assigns(:style_group))
  end

  test "should show style_group" do
    get :show, id: @style_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @style_group
    assert_response :success
  end

  test "should update style_group" do
    put :update, id: @style_group, style_group: { group_id: @style_group.group_id, music_style_id: @style_group.music_style_id }
    assert_redirected_to style_group_path(assigns(:style_group))
  end

  test "should destroy style_group" do
    assert_difference('StyleGroup.count', -1) do
      delete :destroy, id: @style_group
    end

    assert_redirected_to style_groups_path
  end
end
