class CreateRidesUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :rides_users do |t|
      t.integer :ride_id
      t.integer :user_id
    end
  end
end
