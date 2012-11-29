module PagesHelper
  
  def preview(location, page)
    html = Nokogiri.parse(location.site_template.layout.html)
    page.all_widgets.group_by(&:section).each do |section, widgets|
      html_section = html.at_css(".#{section},#{section}")
      html_section.inner_html = widgets.map(&:html).join if html_section
    end
    html.to_html
  end
end
