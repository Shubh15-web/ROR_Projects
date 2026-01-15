class User < ApplicationRecord
  has_secure_password
  
  has_many :vehicles, dependent: :destroy
  has_many :bookings, dependent: :destroy
  
  validates :email, presence: { message: "Please enter email address" }, 
                    uniqueness: { message: "Email already exists" },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "Please enter valid email format" }
  validates :name, presence: { message: "Please enter your name" },
                  length: { minimum: 2, message: "Name must be at least 2 characters" }
  validates :role, presence: { message: "Please select user role" }, 
                  inclusion: { in: %w[admin user], message: "Role must be admin or user" }
  validates :password, presence: { message: "Please enter password" },
                      length: { minimum: 6, message: "Password must be at least 6 characters" }, on: :create
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "role", "updated_at"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["vehicles", "bookings"]
  end
  

end
