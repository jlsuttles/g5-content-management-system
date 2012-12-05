module PagesHelper
  
  def self.preview(location, page)
    return process(location, page)
  end
  
  def preview(location, page)
    # grab the layout
    html = Nokogiri.parse(location.site_template.layout.html)
    # put widgets in their section in the layout
    page.all_widgets.group_by(&:section).each do |section, widgets|
      html_section = html.at_css(".#{section},#{section}")
      html_section.inner_html = widgets.map(&:html).join if html_section
    end
    # return the modified layout
    html.to_html
  end
end
