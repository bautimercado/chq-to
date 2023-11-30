require 'date'

class TemporalLink < ApplicationRecord
  validates :expiration_date, presence: true
  validates_date :expiration_date, after: lambda { Date.current }

  def redirect(_link)
    if Date.today < expiration_date
      true
    else
      false
    end
  end
end