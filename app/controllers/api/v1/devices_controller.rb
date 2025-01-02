module Api
    module V1
      class DevicesController < ApplicationController
        skip_before_action :verify_authenticity_token

        before_action :set_device, only: [:update, :destroy]
        after_action :update_restaurant_status, only: [:create, :update]
        # POST /api/v1/devices
        def create
            @device = Device.new(device_params)
            if @device.save
                render json: @device, status: :created
            else
                render json: @device.errors, status: :unprocessable_entity
            end
        end
        # PATCH/PUT /api/v1/devices/:id
        def update
          if @device.update(device_params)
            render json: @device
          else
            render json: @device.errors, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/devices/:id
        def destroy
            @device.destroy
            render json: { message: 'Device deleted' }
        end
  
        private
          
          def set_device
            @device = Device.find(params[:id])
          end
    
          def device_params
              params.require(:device).permit(:name, :status, :restaurant_id)
          end

          def update_restaurant_status
            UpdateRestaurantStatusJob.perform_async(@device.restaurant_id)
          end
      end
    end
  end