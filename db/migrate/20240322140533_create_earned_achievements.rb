class CreateEarnedAchievements < ActiveRecord::Migration[7.1]
  def change
    create_table :earned_achievements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :achievement, null: false, foreign_key: true
      t.date :earn_date

      t.timestamps
    end
  end
end
