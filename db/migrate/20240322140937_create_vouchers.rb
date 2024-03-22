class CreateVouchers < ActiveRecord::Migration[7.1]
  def change
    create_table :vouchers do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :value
      t.date :valability
      t.string :barcode
      t.boolean :is_valid
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
