class Asset < ActiveRecord::Base

  validates :url, presence: true, uniqueness: true
  #validates :name, presence: true

  belongs_to :website

end

