module ApplicationHelper

  def full_title(page_title = '')
    base_title = "P-Ride App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def get_price(item)
    begin
      return ((item.distance)*(item.price)).round(-1)
    rescue
    end
  end
end
