class Asset < ActiveRecord::Base

  validates :url, presence: true, uniqueness: true

  belongs_to :website

end

