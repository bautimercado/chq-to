require 'date'

class TemporalLink < Link
  validates :expiration_date, presence: true
  validates_date :expiration_date, on_or_after: lambda { Date.current }

  def redirect
    if Date.current <= self.expiration_date
      { success: true }
    else
      { success: false, status: 404 }
    end
  end
end