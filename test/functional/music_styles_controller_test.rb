require 'test_helper'

class MusicStylesControllerTest < ActionController::TestCase
  setup do
    @music_style = music_styles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:music_styles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music_style" do
    assert_difference('MusicStyle.count') do
      post :create, music_style: { name: @music_style.name }
    end

    assert_redirected_to music_style_path(assigns(:music_style))
  end

  test "should show music_style" do
    get :show, id: @music_style
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @music_style
    assert_response :success
  end

  test "should update music_style" do
    put :update, id: @music_style, music_style: { name: @music_style.name }
    assert_redirected_to music_style_path(assigns(:music_style))
  end

  test "should destroy music_style" do
    assert_difference('MusicStyle.count', -1) do
      delete :destroy, id: @music_style
    end

    assert_redirected_to music_styles_path
  end
end
