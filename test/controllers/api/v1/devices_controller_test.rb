require 'test_helper'

module Api
  module V1
    class DevicesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @restaurant = restaurants(:one)
        @device = devices(:one)
      end

      test "should create device with valid attributes" do
        assert_difference('Device.count') do
          post api_v1_devices_url, params: { device: { name: 'POS 2', status: 'active', restaurant_id: @restaurant.id } }, as: :json
        end
        assert_response :created
      end

      test "should not create device with invalid status" do
        assert_no_difference('Device.count') do
          post api_v1_devices_url, params: { device: { name: 'POS 2', status: 'invalid_status', restaurant_id: @restaurant.id } }, as: :json
        end
        assert_response :unprocessable_entity
      end

      test "should update device with valid status" do
        patch api_v1_device_url(@device), params: { device: { status: 'active' } }, as: :json
        assert_response :success
        @device.reload
        assert_equal 'active', @device.status
      end

      test "should not update device with invalid status" do
        patch api_v1_device_url(@device), params: { device: { status: 'invalid_status' } }, as: :json
        assert_response :unprocessable_entity
        @device.reload
        assert_not_equal 'invalid_status', @device.status
      end

      test "should destroy device" do
        assert_difference('Device.count', -1) do
          delete api_v1_device_url(@device), as: :json
        end
        assert_response :no_content
      end
    end
  end
end