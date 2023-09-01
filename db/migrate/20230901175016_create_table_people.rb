class CreateTablePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :profession
      t.string :location
      t.integer :level

      t.timestamps
    end
  end
end
