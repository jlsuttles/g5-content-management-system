class SingleDomain < Client
  has_one :website, as: :owner, dependent: :destroy
end
