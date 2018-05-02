class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments
  
  validates :title, :body, presence: true

  def not_awarded_answers
    answers.where(award: false)
  end
end
