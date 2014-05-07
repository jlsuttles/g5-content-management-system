class WebCorporatePageTemplate < WebTemplate
  def all_widgets
    widgets.not_meta_description + website.try(:website_template).try(:widgets).to_a
  end

  def head_widgets
    website.try(:website_template).try(:head_widgets).to_a
  end

  def htaccess_substitution
    ["/", relative_path, "/"].join
  end

  def compile_path
    File.join(website_compile_path.to_s, relative_path, "index.html") if web_page_template?
  end

  def relative_path
    "/#{slug}"
  end
end
