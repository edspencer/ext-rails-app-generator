class CreateControllers < ActiveRecord::Migration
  def self.up
    create_table :controllers do |t|
      t.integer :model_id
      t.string :name
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id
      t.string :namespace
      t.boolean :responds_to_html
      t.boolean :responds_to_xml
      t.boolean :responds_to_json

      t.timestamps
    end
  end

  def self.down
    drop_table :controllers
  end
end
