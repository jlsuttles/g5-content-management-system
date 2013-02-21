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
        if widget.settings.any?
          template = Liquid::Template.parse(widget.html)
          template.render("setting1" => widget.settings.first.widget_attributes.first, "setting2" => widget.settings.first.widget_attributes.last)
        else
          widget.html 
        end
      end.join
      html_section = html.at_css("[role=#{section}],.#{section},#{section}")
      html_section.inner_html = widget_html if html_section
    end
    # return the modified layout
    html.to_html
  end
end
