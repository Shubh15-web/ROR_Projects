ActiveAdmin.register Vehicle do
  permit_params :license_plate, :owner_name, :vehicle_type, :user_id
  
  index do
    selectable_column
    id_column
    column :license_plate
    column :owner_name
    column :vehicle_type do |vehicle|
      status_tag vehicle.vehicle_type, class: vehicle.vehicle_type
    end
    column :user
    column :created_at
    actions
  end
  
  filter :license_plate
  filter :owner_name
  filter :vehicle_type, as: :select, collection: ['car', 'bike', 'bicycle', 'other']
  filter :user
  
  form do |f|
    f.inputs do
      f.input :license_plate
      f.input :owner_name
      f.input :vehicle_type, as: :select, collection: ['car', 'bike']
      f.input :user, as: :select, collection: User.all.collect { |u| [u.name, u.id] }
    end
    f.actions
  end
end
