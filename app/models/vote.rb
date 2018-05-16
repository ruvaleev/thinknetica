class Vote < ApplicationRecord
  belongs_to :object, polymorphic: true, optional: true
  belongs_to :user

  validates :object_id, presence: true
  validates :user_id, presence: true
end
