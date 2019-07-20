class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.datetime :in, null: false
      t.datetime :out
      t.integer :staff_id, null: false, index: true
      t.integer :locael_id, null: false, index: true

      t.timestamps
    end
  end
end
