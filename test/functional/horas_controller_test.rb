require 'test_helper'

class HorasControllerTest < ActionController::TestCase
  setup do
    @hora = horas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:horas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hora" do
    assert_difference('Hora.count') do
      post :create, hora: { endTime: @hora.endTime, name: @hora.name, startTime: @hora.startTime }
    end

    assert_redirected_to hora_path(assigns(:hora))
  end

  test "should show hora" do
    get :show, id: @hora
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hora
    assert_response :success
  end

  test "should update hora" do
    put :update, id: @hora, hora: { endTime: @hora.endTime, name: @hora.name, startTime: @hora.startTime }
    assert_redirected_to hora_path(assigns(:hora))
  end

  test "should destroy hora" do
    assert_difference('Hora.count', -1) do
      delete :destroy, id: @hora
    end

    assert_redirected_to horas_path
  end
end
