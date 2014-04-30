class MultiDomainClient < Client
  def url_formatter_class
    URLFormat::MultiDomainFormatter
  end
end
