# Create sample users
user1 = User.create!(
  name: "John Doe",
  email: "john@example.com", 
  role: "user",
  password: "password123"
)

user2 = User.create!(
  name: "Jane Smith",
  email: "jane@example.com",
  role: "admin", 
  password: "password123"
)

# Create parking slots
slot1 = ParkingSlot.create!(
  slot_number: "A001",
  floor: 1,
  status: "free",
  slot_type: "car"
)

slot2 = ParkingSlot.create!(
  slot_number: "A002", 
  floor: 1,
  status: "free",
  slot_type: "bike"
)

# Create vehicles
vehicle1 = Vehicle.create!(
  license_plate: "DL01AB1234",
  owner_name: "John Doe",
  vehicle_type: "car",
  user: user1
)

puts "Sample data created successfully!"