class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {scope: :release_year} #checks to see if title is unique within a given year
  validates :released, inclusion: {in: [true, false]}
  validates :release_year, presence: true, if: :released
  validate :check_release_year
  validates :artist_name, presence: true

  def check_release_year
    if self.release_year # check to see if release_year is there
      if self.release_year < Time.now.year
        return true
      else
        self.errors[:release_year] << "Not a valid release year"
      end
    end
  end

end
