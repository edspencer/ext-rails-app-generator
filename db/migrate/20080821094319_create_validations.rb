class CreateValidations < ActiveRecord::Migration
  def self.up
    create_table :validations do |t|
      t.integer :column_id
      t.string :validation_type

      t.timestamps
    end
  end

  def self.down
    drop_table :validations
  end
end
