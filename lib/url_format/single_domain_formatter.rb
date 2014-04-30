class URLFormat::SingleDomainFormatter < URLFormat::Formatter
  def format
    "#{seo_optimized_path}/#{@owner.urn}/#{@web_template.slug}"
  end
end
