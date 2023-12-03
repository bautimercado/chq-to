class EphemeralLink < Link
  before_create :enable_access

  #validates :accessed, inclusion: { in: [true, false] },
  #          exclusion: { in: [nil] }

  def redirect
    puts "IIIINNNN EPHEMERAL REDIREEEECT"
    puts "STATE: #{self.accessed}"
    if self.accessed
      { success: false, status: 403 }
    else
      puts "CORRECT!"
      self.update(accessed: true)
      puts "NEW STATE: #{self.accessed}"
      { success: true }
    end
  end

  private

  def enable_access
    self.accessed = false
  end
end