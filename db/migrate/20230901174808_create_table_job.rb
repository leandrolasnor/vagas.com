class CreateTableJob < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :company
      t.string :title
      t.string :description
      t.string :location
      t.integer :level

      t.timestamps
    end
  end
end
