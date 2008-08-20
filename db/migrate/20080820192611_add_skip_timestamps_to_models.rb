class AddSkipTimestampsToModels < ActiveRecord::Migration
  def self.up
    add_column :models, :skip_timestamps, :boolean, :default => false
  end

  def self.down
    remove_column :models, :skip_timestamps
  end
end
