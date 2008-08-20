class AddTimestampsToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :created_at, :datetime
    add_column :sites, :updated_at, :datetime
  end

  def self.down
    remove_column :sites, :updated_at
    remove_column :sites, :created_at
  end
end
