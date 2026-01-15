class CreateParkingSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :parking_slots do |t|
      t.string :slot_number
      t.integer :floor
      t.string :status
      t.string :slot_type

      t.timestamps
    end
  end
end
