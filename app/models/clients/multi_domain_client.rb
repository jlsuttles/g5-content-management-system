class MultiDomainClient < Client
  def url_formatter_class
    URLFormat::MultiDomainFormatter
  end

  def stylesheets_compiler_class
    StaticWebsite::Compiler::Stylesheets
  end

  def javascripts_compiler_class
    StaticWebsite::Compiler::Javascripts
  end
end
