class CreateWorkBreaks < ActiveRecord::Migration[5.2]
  def change
    create_table :work_breaks do |t|
      t.datetime :in, null: false
      t.datetime :out
      t.integer :work_id, null: false, index: true

      t.timestamps
    end
  end
end
