class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy

  def author_of(question_or_answer)
  	true if self.id == question_or_answer.user_id && self.present?
  end

end
