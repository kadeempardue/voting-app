module ApplicationHelper

  def variant_helper
    if flash[:notice]
      "primary"
    elsif flash[:alert]
      "danger"
    end
  end
end
