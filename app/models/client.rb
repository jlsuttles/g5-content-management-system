class Client < ActiveRecord::Base
  include HasManyPrioritizedSettings

  attr_accessible :uid,
                  :name

  has_many :locations
  has_many :websites, through: :locations

  validates :uid, presence: true, uniqueness: true
  validates :name, presence: true
end
