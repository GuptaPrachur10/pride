module DriversHelper
  def gravatar_for(driver, size: 80)
    gravatar_id = Digest::MD5::hexdigest(driver.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: driver.name, class: "gravatar")
  end
end
