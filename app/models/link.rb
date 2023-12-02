class Link < ApplicationRecord
  belongs_to :user

  validates :url, presence: true, format: {
    with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix,
    message: "is not a valid URL"
  }

  validates :type, presence: true
end
