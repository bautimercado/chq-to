require 'resolv'

class Access < ApplicationRecord
  belongs_to :link

  validates :ip_address, format: { with: Resolv::IPv4::Regex }
  validates :link, presence: true
end
