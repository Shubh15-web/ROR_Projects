class CreateVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate
      t.string :owner_name
      t.string :vehicle_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
