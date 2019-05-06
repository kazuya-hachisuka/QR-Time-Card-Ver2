class CreateLocales < ActiveRecord::Migration[5.2]
  def change
    create_table :locales do |t|
      t.string :locale_name, limit: 191, null: false, unique: true, index: true
      t.integer :admin_id, null: false, index: true
      t.string :control_number, limit: 191, null: false, index: true
      t.string :password_digest, limit: 191, null:false
      t.string :remember_token, limit: 191
      t.timestamps
    end
  end
end
