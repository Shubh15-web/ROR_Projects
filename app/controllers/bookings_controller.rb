class BookingsController < ApplicationController
  before_action :require_login
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = current_user.bookings.includes(:parking_slot, :vehicle).order(created_at: :desc)
  end

  def show
  end

  def new
    @booking = current_user.bookings.build
    @available_slots = ParkingSlot.available
  end

  def create
    license_plate = params[:booking][:vehicle_license_plate]
    
    if license_plate.blank?
      flash.now[:alert] = "Please enter Vehicle Number"
      @available_slots = ParkingSlot.available
      render :new and return
    end
    
    # Find or create vehicle
    vehicle = current_user.vehicles.find_by(license_plate: license_plate.upcase)
    unless vehicle
      vehicle = current_user.vehicles.build(
        license_plate: license_plate.upcase,
        owner_name: current_user.name,
        vehicle_type: 'car'
      )
      unless vehicle.save
        @booking = current_user.bookings.build
        @booking.vehicle = vehicle
        @available_slots = ParkingSlot.available
        render :new and return
      end
    end
    
    @booking = current_user.bookings.build(booking_params)
    @booking.vehicle = vehicle
    @booking.start_time = Time.current unless @booking.start_time
    @booking.status = 'active'
    
    if @booking.save
      @booking.parking_slot.update(status: 'occupied')
      redirect_to @booking, notice: 'Booking created successfully.'
    else
      @available_slots = ParkingSlot.available
      render :new
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Booking updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @booking.parking_slot.update(status: 'free')
    @booking.update(status: 'cancelled')
    redirect_to bookings_path, notice: 'Booking cancelled successfully.'
  end

  private

  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:parking_slot_id, :start_time, :end_time, :status)
  end
end
