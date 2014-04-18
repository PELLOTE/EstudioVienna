require 'test_helper'

class BookingTimesControllerTest < ActionController::TestCase
  setup do
    @booking_time = booking_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:booking_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booking_time" do
    assert_difference('BookingTime.count') do
      post :create, booking_time: { booking_id: @booking_time.booking_id, hora_id: @booking_time.hora_id }
    end

    assert_redirected_to booking_time_path(assigns(:booking_time))
  end

  test "should show booking_time" do
    get :show, id: @booking_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @booking_time
    assert_response :success
  end

  test "should update booking_time" do
    put :update, id: @booking_time, booking_time: { booking_id: @booking_time.booking_id, hora_id: @booking_time.hora_id }
    assert_redirected_to booking_time_path(assigns(:booking_time))
  end

  test "should destroy booking_time" do
    assert_difference('BookingTime.count', -1) do
      delete :destroy, id: @booking_time
    end

    assert_redirected_to booking_times_path
  end
end
