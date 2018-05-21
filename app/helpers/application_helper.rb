module ApplicationHelper
  def votable_url(positive)
    object = controller.controller_name.singularize
    logger.debug "object is #{object}"
    votes_path(:object_type => object, :resource_id => controller.instance_variable_get("@#{object}").id, positive: positive)
  end
end
