require 'bcrypt'

class PrivateLink < Link
  before_save :hash_password

  validates :password, presence: true

  def redirect(attempt_password)
    if BCrypt::Password.new(self.password) == attempt_password
      { success: true }
    else
      { success: false, messsage: "The password entered is incorrect, please try again." }
    end
  end

  private
  def hash_password
    self.password = BCrypt::Password.create(self.password)
  end

end