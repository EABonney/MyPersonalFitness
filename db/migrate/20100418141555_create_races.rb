class CreateRaces < ActiveRecord::Migration
  def self.up
    create_table :races do |t|
      t.string :name
      t.string :race_type
      t.string :race_distance
      t.float :swim_distance,       :default => 0.0
      t.float :bike_distance,       :default => 0.0
      t.float :run_distance,        :default => 0.0
      t.date :race_date
      t.time :race_time
      t.string :city
      t.string :state
      
      t.timestamps
    end
  end

  def self.down
    drop_table :races
  end
end
