class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :votes, as: :object, dependent: :destroy
  
  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attr| attr['file'].nil? }

  def not_awarded_answers
    answers.where(award: false)
  end

  def rating
    Vote.where(object_id: self.id, positive:true).count - Vote.where(object_id: self.id, positive:false).count
  end
end
