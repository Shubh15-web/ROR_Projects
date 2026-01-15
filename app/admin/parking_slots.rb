ActiveAdmin.register ParkingSlot do
  permit_params :slot_number, :floor, :status, :slot_type
  
  index do
    selectable_column
    id_column
    column :slot_number
    column :floor
    column :status do |slot|
      status_tag slot.status, class: slot.status
    end
    column :slot_type
    column :created_at
    actions
  end
  
  filter :slot_number
  filter :floor
  filter :status, as: :select, collection: ['free', 'occupied', 'maintenance', 'reserved']
  filter :slot_type, as: :select, collection: ['car', 'bike', 'bicycle', 'other']
  
  form do |f|
    f.inputs do
      f.input :slot_number
      f.input :floor
      f.input :status, as: :select, collection: ['free', 'occupied', 'maintenance', 'reserved']
      f.input :slot_type, as: :select, collection: ['car', 'bike', 'bicycle', 'other']
    end
    f.actions
  end
end
