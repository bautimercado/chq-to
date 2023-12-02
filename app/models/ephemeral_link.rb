class EphemeralLink < Link
  before_save :enable_access

  #validates :accessed, inclusion: { in: [true, false] },
  #          exclusion: { in: [nil] }

  private

  def enable_access
    self.accessed = false
  end
end