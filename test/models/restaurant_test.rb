require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  def setup
	  @restaurant = Restaurant.new(name: "MyRestaurant", status: "active")
  end

  test "should be valid" do
	  assert @restaurant.valid?
  end

  test "name should be present" do
	  @restaurant.name = nil
	  assert_not @restaurant.valid?
  end
end
