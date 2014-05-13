class URLFormat::SingleDomainFormatter < URLFormat::Formatter
  def format
    if corporate?
      return URLFormat::Formatter::ROOT if web_home_template?

      "/#{@web_template.slug}"
    else
      return base_url if web_home_template?

      "#{base_url}/#{@web_template.slug}"
    end
  end

  private

  def base_url
    "#{seo_optimized_path}/#{@web_template.website.urn}"
  end

  def corporate?
    @web_template.website.corporate?
  end
end
