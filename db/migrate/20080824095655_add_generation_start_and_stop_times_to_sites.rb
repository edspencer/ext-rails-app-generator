class AddGenerationStartAndStopTimesToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :generation_start_time, :datetime
    add_column :sites, :generation_stop_time, :datetime
  end

  def self.down
    remove_column :sites, :generation_stop_time
    remove_column :sites, :generation_start_time
  end
end
