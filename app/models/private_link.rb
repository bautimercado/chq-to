require 'bcrypt'

class PrivateLink < Link
  before_save :hash_password

  validates :password, presence: true

  def redirect(entered_passwd)
    if entered_passwd == password
      true
    else
      false
    end
  end

  private
  def hash_password
    self.password = BCrypt::Password.create(self.password)
  end

end