class SingleDomain < Client
  has_one :website, as: :owner, dependent: :destroy

  def url_formatter_class
    URLFormat::SingleDomainFormatter
  end
end
