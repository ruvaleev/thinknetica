class Vote < ApplicationRecord
  validates :answer_id, presence: true
  validates :user_id, presence: true
  validates :positive, presence: true
end
