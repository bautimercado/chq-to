class PrivateLink < ApplicationRecord
  validates :password, presence: true

  def redirect(entered_passwd)
    if entered_passwd == password
      true
    else
      false
    end
  end

end