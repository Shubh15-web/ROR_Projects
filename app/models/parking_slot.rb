class ParkingSlot < ApplicationRecord
  has_many :bookings, dependent: :destroy
  
  validates :slot_number, presence: { message: "Please enter slot number" }, 
                         uniqueness: { message: "Slot number already exists" },
                         format: { with: /\A[A-Z]\d{3}\z/, message: "Slot number format should be like A001, B205" }
  validates :floor, presence: { message: "Please enter floor number" },
                   numericality: { greater_than: 0, less_than_or_equal_to: 10, message: "Floor must be between 1 and 10" }
  validates :status, presence: { message: "Please select slot status" }, 
                    inclusion: { in: %w[free occupied maintenance reserved], message: "Status must be free, occupied, maintenance, or reserved" }
  validates :slot_type, presence: { message: "Please select vehicle type" }, 
                       inclusion: { in: %w[car bike bicycle other], message: "Vehicle type must be car, bike, bicycle, or other" }
  
  scope :available, -> { where(status: 'free') }
  scope :occupied, -> { where(status: 'occupied') }
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "floor", "id", "slot_number", "slot_type", "status", "updated_at"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["bookings"]
  end
end
