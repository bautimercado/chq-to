class Link < ApplicationRecord
  before_save :create_slug

  belongs_to :user

  validates :url, presence: true, format: {
    with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix,
    message: "is not a valid URL"
  }

  validates :type, presence: true

  private
  def create_slug
    # utf8_url = url.force_encoding('UTF-8')
    hashed_url = Digest::SHA2.hexdigest(self.url)
    short_hash = Base64.urlsafe_encode64(hashed_url)[0, 8]
    self.slug = "#{Rails.application.routes.default_url_options[:host]}l/#{short_hash}"
  end
end
