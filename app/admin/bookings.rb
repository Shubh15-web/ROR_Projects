ActiveAdmin.register Booking do
  permit_params :user_id, :parking_slot_id, :vehicle_id, :start_time, :end_time, :status
  
  index do
    selectable_column
    id_column
    column :user do |booking|
      "#{booking.user.name} (#{booking.user.email})"
    end
    column :parking_slot do |booking|
      "#{booking.parking_slot.slot_number} - Floor #{booking.parking_slot.floor}"
    end
    column :vehicle do |booking|
      "#{booking.vehicle.license_plate} - #{booking.vehicle.owner_name}"
    end
    column :start_time
    column :status do |booking|
      status_tag booking.status
    end
    actions
  end
  
  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.all.map { |u| ["#{u.name} (#{u.email})", u.id] }
      f.input :parking_slot, as: :select, collection: ParkingSlot.all.map { |ps| ["#{ps.slot_number} - Floor #{ps.floor} (#{ps.slot_type.capitalize})", ps.id] }
      f.input :vehicle, as: :select, collection: Vehicle.all.map { |v| ["#{v.license_plate} - #{v.owner_name}", v.id] }
      f.input :start_time
      f.input :end_time
      f.input :status, as: :select, collection: ['active', 'completed', 'cancelled']
    end
    f.actions
  end
end
