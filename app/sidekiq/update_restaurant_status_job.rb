class UpdateRestaurantStatusJob
  include Sidekiq::Job

  def perform(restaurant_id)
    RestaurantStatusService.new(restaurant_id).update_status
  end
end
