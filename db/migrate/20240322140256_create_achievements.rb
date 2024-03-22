class CreateAchievements < ActiveRecord::Migration[7.1]
  def change
    create_table :achievements do |t|
      t.string :name
      t.string :description
      t.integer :point_value

      t.timestamps
    end
  end
end
