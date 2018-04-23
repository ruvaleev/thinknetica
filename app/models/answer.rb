class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  
  validates :body, presence: true

  scope :best, ->(question) { where(award: true, question_id: question.id) }

  def make_best
    Question.find(self.question_id).answers.update(award: false)
    self.update(award: true)
  end
end
