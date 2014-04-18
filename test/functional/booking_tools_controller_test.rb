require 'test_helper'

class BookingToolsControllerTest < ActionController::TestCase
  setup do
    @booking_tool = booking_tools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:booking_tools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booking_tool" do
    assert_difference('BookingTool.count') do
      post :create, booking_tool: { booking_id: @booking_tool.booking_id, tool_id: @booking_tool.tool_id }
    end

    assert_redirected_to booking_tool_path(assigns(:booking_tool))
  end

  test "should show booking_tool" do
    get :show, id: @booking_tool
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @booking_tool
    assert_response :success
  end

  test "should update booking_tool" do
    put :update, id: @booking_tool, booking_tool: { booking_id: @booking_tool.booking_id, tool_id: @booking_tool.tool_id }
    assert_redirected_to booking_tool_path(assigns(:booking_tool))
  end

  test "should destroy booking_tool" do
    assert_difference('BookingTool.count', -1) do
      delete :destroy, id: @booking_tool
    end

    assert_redirected_to booking_tools_path
  end
end
