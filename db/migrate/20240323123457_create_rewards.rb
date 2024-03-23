class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.string :name
      t.string :description
      t.boolean :is_active
      t.integer :point_value
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
