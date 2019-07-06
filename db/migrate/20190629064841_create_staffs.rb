class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.string :family_name, null: false, index: true
      t.string :family_name_kana, null: false, index: true
      t.string :given_name, null: false, index: true
      t.string :given_name_kana, null: false, index: true
      t.integer :locale_id, null: false, index: true
      t.integer :admin_id, null: false
      t.text :qrcode
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
