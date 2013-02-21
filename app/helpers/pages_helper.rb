module PagesHelper
  
  def self.preview(location, page)
    return process(location, page)
  end
  
  def preview(location, page)
    # grab the layout
    html = Nokogiri.parse(location.site_template.page_layout.html)
    # put widgets in their section in the layout
    page.all_widgets.group_by(&:section).each do |section, widgets|
      widget_html = widgets.map do |widget|
        # render widget settings into widget html
        template = Liquid::Template.parse(CGI::unescape(widget.html))
        template.render("widget" => widget)
      end.join
      
      html_section = html.at_css("[role=#{section}],.#{section},#{section}")
      html_section.inner_html = widget_html if html_section
    end
    # return the modified layout
    html.to_html
  end
end
