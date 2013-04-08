module WebTemplatesHelper
  def preview(website, web_template)
    # grab the layout
    html = Nokogiri.parse(website.website_template.web_layout.html)
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
