require 'bcrypt'

class PrivateLink < Link
  before_create :hash_password

  validates :password, presence: true

  def redirect(attempt_password)
    if BCrypt::Password.new(self.password) == attempt_password
      { success: true }
    else
      { success: false, message: "The password entered is incorrect, please try again." }
    end
  end

  private
  def hash_password
    self.password = BCrypt::Password.create(self.password)
  end

end