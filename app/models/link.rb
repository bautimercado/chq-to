require 'securerandom'

class Link < ApplicationRecord
  before_create :create_slug
  belongs_to :user

  validates :type, presence: true
  validates :url, presence: true, format: {
    with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix,
    message: "is not a valid URL"
  }

  private

  def create_slug
    # utf8_url = url.force_encoding('UTF-8')
    #hashed_url = Digest::SHA2.hexdigest(self.url)
    #unique_hash = "#{hashed_url}-#{self.id}"
    #self.slug = Base64.urlsafe_encode64(unique_hash)[0, 8]
    self.slug = SecureRandom.uuid[0..7]
    self.short_url = "#{Rails.application.routes.default_url_options[:host]}/links/r/#{self.slug}"
  end
end
