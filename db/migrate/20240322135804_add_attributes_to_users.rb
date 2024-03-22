class AddAttributesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :provider, :string
    add_column :users, :phone_number, :string
    add_column :users, :balance, :decimal
    add_column :users, :leaderboard_position, :integer
  end
end
