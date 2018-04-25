class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  
  validates :title, :body, presence: true

  def not_awarded_answers
    # answers - Answer.best
    self.answers.where(award: false)
  end
end
