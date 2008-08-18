class AddFieldsToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :scm, :string
    add_column :sites, :rails_version,  :string
    add_column :sites, :vendor_rails,   :boolean, :default => false
    add_column :sites, :test_framework, :string
    add_column :sites, :views_type,     :string
    add_column :sites, :capify,         :boolean, :default => false
  end

  def self.down
    remove_column :sites, :capify
    remove_column :sites, :views_type
    remove_column :sites, :test_framework
    remove_column :sites, :vendor_rails
    remove_column :sites, :rails_version
    remove_column :sites, :scm
  end
end
