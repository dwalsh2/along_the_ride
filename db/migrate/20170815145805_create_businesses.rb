class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.integer :waypoint_id
      t.string :name
      t.string :image_url
      t.string :url
      t.string :phone
      t.string :rating
      t.string :location
      t.string :yelp_api_return

      t.timestamps

    end
  end
end
