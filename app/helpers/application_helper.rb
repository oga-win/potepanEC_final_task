Base_title = "BIGBAG Store"

module ApplicationHelper
  def full_title(page_title)
    if page_title.blank?
      "#{Base_title}"
    else
      "#{page_title} - #{Base_title}"
    end
  end
end
