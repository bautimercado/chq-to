require 'date'

class TemporalLink < Link
  validates :expiration_date, presence: true
  validates_date :expiration_date, on_or_after: lambda { Date.current }

  def redirect(_link)
    if Date.today <= self.expiration_date
      true
    else
      false
    end
  end
end