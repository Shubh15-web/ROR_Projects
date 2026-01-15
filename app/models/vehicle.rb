class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  
  validates :license_plate, presence: { message: "Please enter Vehicle Number" }, 
                           uniqueness: { message: "Vehicle Number already registered" },
                           format: { with: /\A[A-Z]{2}[0-9]{1,2}[A-Z]{1,2}[0-9]{1,4}\z/, message: "Please enter valid Vehicle Number (e.g., DL01AB1234, MH12DE5678)" }
  validates :owner_name, presence: { message: "Please enter Owner Name" },
                        length: { minimum: 2, message: "Owner Name must be at least 2 characters" }
  validates :vehicle_type, presence: { message: "Please select Vehicle Type" }, 
                          inclusion: { in: %w[car bike bicycle other], message: "Vehicle Type must be car, bike, bicycle, or other" }
  validates :user_id, presence: { message: "Please select User" }
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "license_plate", "owner_name", "updated_at", "user_id", "vehicle_type"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["user", "bookings"]
  end
end
