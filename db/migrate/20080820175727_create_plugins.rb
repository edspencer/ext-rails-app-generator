class CreatePlugins < ActiveRecord::Migration
  def self.up
    create_table :plugins do |t|
      t.string :name
      t.string :remote_url
      t.string :local_path
      t.string :generator_name
      t.text   :default_generator_argument
      
      t.boolean :selected_by_default, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :plugins
  end
end
