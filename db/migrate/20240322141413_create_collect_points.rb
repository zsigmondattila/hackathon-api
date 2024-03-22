class CreateCollectPoints < ActiveRecord::Migration[7.1]
  def change
    create_table :collect_points do |t|
      t.string :type
      t.string :address
      t.decimal :latitude
      t.decimal :longitude
      t.string :contact_phone
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
