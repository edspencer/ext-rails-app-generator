class CreateAssociations < ActiveRecord::Migration
  def self.up
    create_table :associations do |t|
      t.integer :model_id
      t.integer :foreign_model_id
      t.string :association_type

      t.timestamps
    end
  end

  def self.down
    drop_table :associations
  end
end
