class WebHomeTemplate < WebTemplate
  def all_widgets
    widgets + website.try(:website_template).try(:widgets).to_a
  end

  def head_widgets
    website.try(:website_template).try(:head_widgets).to_a
  end

  def compile_path
    File.join(website_compile_path.to_s, "index.html") if website_compile_path
  end

  def htaccess_substitution
    relative_path
  end

  def relative_path
    "/"
  end

  def page_url
    location.domain if location.domain
  end
end
