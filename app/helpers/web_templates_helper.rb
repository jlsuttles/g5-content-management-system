module WebTemplatesHelper

  def self.preview(location, web_template)
    return process(location, web_template)
  end

  def preview(location, web_template)
    # grab the layout
    html = Nokogiri.parse(location.website_template.web_layout.html)
    # put widgets in their section in the layout
    web_template.all_widgets.group_by(&:section).each do |section, widgets|
      html_section = html.at_css("[role=#{section}],.#{section},#{section}")
      if html_section
        widget_html = widgets.map(&:liquidized_html).join
        html_section.inner_html = widget_html
      end
    end
    # return the modified layout
    html.to_html
  end
end
