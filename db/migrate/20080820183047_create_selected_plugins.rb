class CreateSelectedPlugins < ActiveRecord::Migration
  def self.up
    create_table :selected_plugins do |t|
      t.integer :site_id
      t.integer :plugin_id
      t.text :generator_argument

      t.timestamps
    end
  end

  def self.down
    drop_table :selected_plugins
  end
end
