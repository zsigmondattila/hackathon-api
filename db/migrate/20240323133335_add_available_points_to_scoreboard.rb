class AddAvailablePointsToScoreboard < ActiveRecord::Migration[7.1]
  def change
    add_column :scoreboards, :available_points, :integer
  end
end
