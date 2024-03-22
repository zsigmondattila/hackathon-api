class CreateScoreboards < ActiveRecord::Migration[7.1]
  def change
    create_table :scoreboards do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :points
      t.date :points_date

      t.timestamps
    end
  end
end
