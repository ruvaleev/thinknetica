class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable
  
  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments

  def not_awarded_answers
    answers.where(award: false)
  end
end
