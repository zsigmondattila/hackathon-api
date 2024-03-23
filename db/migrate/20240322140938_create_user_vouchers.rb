class CreateUserVouchers < ActiveRecord::Migration[7.1]
  def change
    create_table :user_vouchers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :voucher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
