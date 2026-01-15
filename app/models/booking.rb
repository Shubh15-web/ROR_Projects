class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :parking_slot
  belongs_to :vehicle
  
  validates :start_time, presence: { message: "Please select Start Time" }
  validates :status, presence: { message: "Please select Booking Status" }, 
                    inclusion: { in: %w[active completed cancelled], message: "Booking Status must be active, completed, or cancelled" }
  validates :parking_slot_id, presence: { message: "Please select Parking Slot" }
  
  validate :end_time_after_start_time
  validate :slot_availability
  
  scope :active, -> { where(status: 'active') }
  scope :completed, -> { where(status: 'completed') }
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "end_time", "id", "parking_slot_id", "start_time", "status", "updated_at", "user_id", "vehicle_id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["parking_slot", "user", "vehicle"]
  end
  
  private
  
  def end_time_after_start_time
    return unless end_time && start_time
    
    if end_time <= start_time
      errors.add(:end_time, "End Time must be after Start Time")
    end
  end
  
  def slot_availability
    return unless parking_slot_id && start_time
    
    if parking_slot && parking_slot.status != 'free'
      errors.add(:parking_slot_id, "Selected Parking Slot is not available")
    end
  end
end
