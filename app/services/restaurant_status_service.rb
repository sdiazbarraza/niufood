class RestaurantStatusService
    def initialize(restaurant_id)
        begin
            @restaurant = Restaurant.find(restaurant_id)
        rescue => exception
            raise ActiveRecord::RecordNotFound, "Restaurant not found"
        end
    end
    
    # Actualizamos el estado del restaurant en base a los estados de los dispositivos
    def update_status
        total_device = @restaurant.devices.count
        if @restaurant.devices.where(status: ["maintenance"]).count == total_device
            @restaurant.update(status: "problema");
        elsif @restaurant.devices.where(status: ["maintenance"]).count > 0
            @restaurant.update(status: "warning");
        else
            @restaurant.update(status: "operativo");
        end
      
    end
  end