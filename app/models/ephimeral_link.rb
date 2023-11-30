class EphimeralLink < ApplicationRecord
  validates :entered, inclusion: { in: [true, false] },
            exclusion: { in: [nil] }
end