class CreateRaceTypes < ActiveRecord::Migration
  def self.up
    create_table :race_types do |t|
      t.string :race_type
      t.string :race_distance
      
    end
  end

  def self.down
    drop_table :race_types
  end
end
