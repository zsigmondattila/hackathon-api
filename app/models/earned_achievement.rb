class EarnedAchievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievement
end
