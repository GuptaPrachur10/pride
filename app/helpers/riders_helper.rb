module RidersHelper
  def gravatar_for(rider, size: 80)
    gravatar_id = Digest::MD5::hexdigest(rider.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: rider.name, class: "gravatar")
  end
end
