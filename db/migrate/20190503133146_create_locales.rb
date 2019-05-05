class CreateLocales < ActiveRecord::Migration[5.2]
  def change
    create_table :locales do |t|
      t.string :locale_name, null: false, unique: true, index: true
      t.integer :admin_id, null: false, index: true
      t.timestamps
    end
  end
end
