class CreateEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :entries do |t|
      t.references :repository, null: true, foreign_key: true
      t.integer :ticket_number, null: true
      t.datetime :start_time
      t.datetime :end_time, null: true
      t.string :description

      t.timestamps
    end
  end
end
