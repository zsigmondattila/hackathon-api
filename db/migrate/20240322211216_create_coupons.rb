class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.decimal :value
      t.string :code
      t.date :valid_until
      t.references :user, null: false, foreign_key: true
      t.references :partner, foreign_key: true

      t.timestamps
    end
  end
end
