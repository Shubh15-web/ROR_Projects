ActiveAdmin.register User do
  permit_params :name, :email, :role, :password, :password_confirmation
  
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role do |user|
      status_tag user.role, class: user.role
    end
    column :created_at
    actions
  end
  
  filter :name
  filter :email
  filter :role, as: :select, collection: ['admin', 'user']
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :role, as: :select, collection: ['admin', 'user']
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
