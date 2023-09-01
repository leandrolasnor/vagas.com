class CreateTableApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.integer :score
      t.integer :job_id, null: false
      t.integer :person_id, null: false

      t.timestamps
    end
    add_foreign_key :applications, :jobs, column: :job_id
    add_foreign_key :applications, :people, column: :person_id
    add_index :applications, :score
  end
end
