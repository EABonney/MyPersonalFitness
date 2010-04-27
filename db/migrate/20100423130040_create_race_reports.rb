class CreateRaceReports < ActiveRecord::Migration
  def self.up
    create_table :race_reports do |t|
      t.string :age_group
      t.time :total_time
      t.integer :age_group_rank
      t.integer :age_group_participants
      t.integer :over_all_rank
      t.integer :total_participants
      t.integer :race_id
      t.integer :user_id
      t.time :swim_time
      t.time :bike_time
      t.time :run_time
      t.time :t1_time
      t.time :t2_time
      t.text :swim_notes
      t.text :bike_notes
      t.text :run_notes
      t.text :t1_notes
      t.text :t2_notes
      t.text :prerace_notes
      t.text :postrace_notes

      t.timestamps
    end
  end

  def self.down
    drop_table :race_reports
  end
end
