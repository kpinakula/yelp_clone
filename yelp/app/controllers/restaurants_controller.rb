class RestaurantsController < ApplicationController
  def index # GET
    @restaurants = Restaurant.order(id: :desc)
  end

  def new # GET
    @restaurant = Restaurant.new
  end

  def create # POST
    @restaurant = Restaurant.create(restaurant_params) # why use instance variable for POST?
    redirect_to '/restaurants'
  end

  def show # GET
    @restaurant = Restaurant.find(params[:id])
  end

  def edit # GET
    @restaurant = Restaurant.find(params[:id])
  end

  def update # PATCH / PUT
    @restaurant = Restaurant.find(params[:id]).update(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id]).destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to '/restaurants'
  end

  # private methods
  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end
end