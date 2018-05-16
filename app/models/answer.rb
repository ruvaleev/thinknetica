class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  has_many :votes, as: :object, dependent: :destroy

  validates :body, presence: true

  scope :best, -> { where(award: true) }

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attr| attr['file'].nil? }

  def make_best
    Answer.transaction do
      question.answers.update_all(award: false)
      update!(award: true)
    end
  end

  def raiting
    Vote.where(object_id: self.id, positive:true).count - Vote.where(object_id: self.id, positive:false).count
  end

end
