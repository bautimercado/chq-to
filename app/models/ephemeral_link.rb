class EphemeralLink < Link
  before_save :enable_access

  #validates :accessed, inclusion: { in: [true, false] },
  #          exclusion: { in: [nil] }

  def redirect
    if accessed
      { success: false, status: 403 }
    else
      self.accessed = true
      { success: true }
    end
  end

  private

  def enable_access
    self.accessed = false
  end
end