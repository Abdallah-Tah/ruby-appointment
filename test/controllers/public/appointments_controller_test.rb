require "test_helper"

class Public::AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_appointments_new_url
    assert_response :success
  end

  test "should get create" do
    get public_appointments_create_url
    assert_response :success
  end

  test "should get status" do
    get public_appointments_status_url
    assert_response :success
  end
end
