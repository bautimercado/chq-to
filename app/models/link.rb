require 'securerandom'

class Link < ApplicationRecord
  before_create :create_slug
  belongs_to :user
  has_many :accesses

  validates :type, presence: true
  validates :url, presence: true, format: {
    with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix,
    message: "is not a valid URL"
  }

  private

  def create_slug
    self.slug = SecureRandom.uuid[0..7]
  end
end
