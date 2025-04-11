class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.references :company, null: false, foreign_key: true
      t.string :full_name
      t.string :email
      t.string :phone
      t.datetime :appointment_date
      t.text :reason
      t.string :status
      t.string :appointment_number

      t.timestamps
    end
    add_index :appointments, :appointment_number, unique: true
  end
end
