require 'test_helper'

class RestaurantStatusServiceTest < ActiveSupport::TestCase
  def setup
    @restaurant = Restaurant.create(name: 'Test Restaurant', status: 'operativo')
  end

  test "should be return problema" do
    3.times { Device.create!(name:'POS', restaurant: @restaurant, status: 'maintenance') }
    service = RestaurantStatusService.new(@restaurant.id)
    service.update_status
    assert_equal 'problema', @restaurant.reload.status
  end

  test "should be return warning" do
    2.times { Device.create!(name: 'Impresoras' ,restaurant: @restaurant, status: 'maintenance') }
    Device.create(name: 'POS' ,restaurant: @restaurant, status: 'active')
    service = RestaurantStatusService.new(@restaurant.id)
    service.update_status
    assert_equal 'warning', @restaurant.reload.status
  end

  test "should be return operativo" do
    3.times { Device.create(name:'POS', restaurant: @restaurant, status: 'active') }
    service = RestaurantStatusService.new(@restaurant.id)
    service.update_status
    assert_equal 'operativo', @restaurant.reload.status
  end

  test "should be return raise error" do
    assert_raises ActiveRecord::RecordNotFound do
      RestaurantStatusService.new(nil)
    end
  end

  test "should be return raise error with id" do
    assert_raises ActiveRecord::RecordNotFound do
      RestaurantStatusService.new(9999999)
    end
  end  
end