class AddUserRefToAppointments < ActiveRecord::Migration[8.0]
  def change
    # Allow null user_id since public appointments won't have one
    add_reference :appointments, :user, null: true, foreign_key: true
  end
end
