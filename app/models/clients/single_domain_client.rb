class SingleDomainClient < Client
  has_one :website, as: :owner, dependent: :destroy

  def url_formatter_class
    URLFormat::SingleDomainFormatter
  end

  def stylesheets_compiler_class
    ClientDeployer::WebsiteCompiler::Stylesheets
  end

  def javascripts_compiler_class
    ClientDeployer::WebsiteCompiler::Javascripts
  end
end
