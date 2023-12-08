require 'resolv'

class Access < ApplicationRecord
  #before_create :assign_values
  belongs_to :link

  validates :ip_address, format: { with: Resolv::IPv4::Regex }

  private

  #def assign_values
  #  self.ip_address = request.remote_ip
  #  self.accessed_date = DateTime.current
  #end
end
