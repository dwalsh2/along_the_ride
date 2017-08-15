class CreateWaypoints < ActiveRecord::Migration
  def change
    create_table :waypoints do |t|
      t.integer :business_id
      t.string :latitude
      t.string :longitude
      t.integer :route_id

      t.timestamps

    end
  end
end
