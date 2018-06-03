class CreateRides < ActiveRecord::Migration[5.1]
  def change
    create_table :rides do |t|
      t.integer :driver_id
      t.integer :nr_passengers
      t.decimal :start_point_lat, precision: 10, scale: 6
      t.decimal :start_point_lng, precision: 10, scale: 6
      t.decimal :end_point_lat, precision: 10, scale: 6
      t.decimal :end_point_lng, precision: 10, scale: 6
      t.datetime :time
    end
  end
end
