require "test_helper"
class DeviceTest < ActiveSupport::TestCase

  def setup
    @restaurant = restaurants(:one)
    @device = Device.new(name: "Device 1", status: "active", restaurant: @restaurant)
  end

  test "should be valid" do
    assert @device.valid?
  end

  test "name should be present" do
    @device.name = nil    
    assert_not @device.valid?
  end

  test "restaurant should be present" do
    @device.restaurant = nil    
    assert_not @device.valid?
  end
end
