class CreateColumns < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
      t.integer :model_id
      t.string :name
      t.string :column_type
      t.string :default_value
      t.boolean :appears_in_views, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :columns
  end
end
