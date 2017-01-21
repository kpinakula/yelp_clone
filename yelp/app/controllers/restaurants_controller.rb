class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params) # why use instance variable for POST?
    redirect_to '/restaurants'
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  # private methods
  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end