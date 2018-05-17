module Ratable
  extend ActiveSupport::Concern

  def rating
    Vote.where(object_id: self.id, positive:true).count - Vote.where(object_id: self.id, positive:false).count
  end
end