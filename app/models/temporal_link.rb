#require 'date_time'

class TemporalLink < Link
  validates :expiration_date, presence: true
  # validates_datetime :expiration_date, on_or_after: lambda { DateTime.current }

  # La validación de arriba está comentada porque no me permite crear links expirados
  # en el seeds.

  def redirect
    if DateTime.current <= self.expiration_date
      { success: true }
    else
      { success: false, status: 404 }
    end
  end
end