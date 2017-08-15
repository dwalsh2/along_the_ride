class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :user_id
      t.string :starting_latitude
      t.string :starting_longitude
      t.string :ending_latitude
      t.string :ending_longitude

      t.timestamps

    end
  end
end
