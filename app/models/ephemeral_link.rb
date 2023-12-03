class EphemeralLink < Link
  before_create :enable_access

  #validates :accessed, inclusion: { in: [true, false] },
  #          exclusion: { in: [nil] }

  def redirect
    if self.accessed
      { success: false, status: 403 }
    else
      self.update(accessed: true)
      { success: true }
    end
  end

  private

  def enable_access
    self.accessed = false
  end
end