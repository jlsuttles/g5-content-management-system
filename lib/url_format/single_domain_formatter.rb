class URLFormat::SingleDomainFormatter < URLFormat::Formatter
  def format
    return base_url if web_home_template?

    "#{base_url}/#{@web_template.slug}"
  end

  private

  def base_url
    "/#{@owner.urn}#{seo_optimized_path}"
  end
end
