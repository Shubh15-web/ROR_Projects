class VehiclesController < ApplicationController
  before_action :require_login
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]

  def index
    @vehicles = current_user.vehicles
  end

  def show
  end

  def new
    @vehicle = current_user.vehicles.build
  end

  def create
    @vehicle = current_user.vehicles.build(vehicle_params)
    if @vehicle.save
      redirect_to @vehicle, notice: 'Vehicle registered successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to @vehicle, notice: 'Vehicle updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @vehicle.destroy
    redirect_to vehicles_path, notice: 'Vehicle deleted successfully.'
  end

  private

  def set_vehicle
    @vehicle = current_user.vehicles.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:license_plate, :owner_name, :vehicle_type)
  end
end
