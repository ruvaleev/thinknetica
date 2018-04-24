class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  
  validates :body, presence: true

  scope :best, -> { where(award: true) }

  def make_best
    Answer.transaction do
      question.answers.update_all(award: false)
      update(award: true)
    end
  end

end
