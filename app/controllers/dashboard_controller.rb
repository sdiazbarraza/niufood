class DashboardController < ApplicationController
    def index
        @restaurants = Restaurant.all
        @devices = @restaurants.map(&:devices).flatten
    end
end