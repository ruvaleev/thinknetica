class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :votes

  def author_of?(resource)
    self.id == resource.user_id
  end

  def voted?(object, positive, object_type)
    Vote.where(object_id: object, user_id: self.id, positive: positive, object_type: object_type).present?
  end

end
