class ParkingSlotsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_parking_slot, only: [:show, :edit, :update, :destroy]

  def index
    @parking_slots = ParkingSlot.all.order(:floor, :slot_number)
  end

  def show
  end

  def new
    @parking_slot = ParkingSlot.new
  end

  def create
    @parking_slot = ParkingSlot.new(parking_slot_params)
    if @parking_slot.save
      redirect_to @parking_slot, notice: 'Parking slot created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @parking_slot.update(parking_slot_params)
      redirect_to @parking_slot, notice: 'Parking slot updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @parking_slot.destroy
    redirect_to parking_slots_path, notice: 'Parking slot deleted successfully.'
  end

  private

  def set_parking_slot
    @parking_slot = ParkingSlot.find(params[:id])
  end

  def parking_slot_params
    params.require(:parking_slot).permit(:slot_number, :floor, :status, :slot_type)
  end
end
