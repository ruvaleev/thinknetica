class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments

  validates :body, presence: true

  scope :best, -> { where(award: true) }

  accepts_nested_attributes_for :attachments

  def make_best
    Answer.transaction do
      question.answers.update_all(award: false)
      update!(award: true)
    end
  end

end
