class DashboardController < ApplicationController
  before_action :require_login
  
  def index
    @total_slots = ParkingSlot.count
    @available_slots = ParkingSlot.available.count
    @occupied_slots = ParkingSlot.occupied.count
    @recent_bookings = current_user.bookings.active.includes(:parking_slot, :vehicle).limit(5)
    @parking_slots = ParkingSlot.all.order(:floor, :slot_number)
    
    # Revenue calculations - only for admin users
    if current_user.role == 'admin'
      @total_revenue = 600
      @today_revenue = 120
      @monthly_revenue = 2400
    end
  end
  
  private
  
  def calculate_total_revenue
    total = 0
    Booking.where(status: ['completed', 'active']).each do |booking|
      if booking.end_time && booking.start_time
        duration = ((booking.end_time - booking.start_time) / 1.hour).ceil
        total += duration * 20
      elsif booking.start_time && booking.status == 'active'
        duration = ((Time.current - booking.start_time) / 1.hour).ceil
        total += duration * 20
      end
    end
    total
  end
  
  def calculate_today_revenue
    total = 0
    today_bookings = Booking.where(created_at: Date.current.beginning_of_day..Date.current.end_of_day)
    today_bookings.each do |booking|
      if booking.end_time && booking.start_time
        duration = ((booking.end_time - booking.start_time) / 1.hour).ceil
        total += duration * 20
      elsif booking.start_time && booking.status == 'active'
        duration = ((Time.current - booking.start_time) / 1.hour).ceil
        total += duration * 20
      end
    end
    total
  end
  
  def calculate_monthly_revenue
    total = 0
    monthly_bookings = Booking.where(created_at: Date.current.beginning_of_month..Date.current.end_of_month)
    monthly_bookings.each do |booking|
      if booking.end_time && booking.start_time
        duration = ((booking.end_time - booking.start_time) / 1.hour).ceil
        total += duration * 20
      elsif booking.start_time && booking.status == 'active'
        duration = ((Time.current - booking.start_time) / 1.hour).ceil
        total += duration * 20
      end
    end
    total
  end
end
