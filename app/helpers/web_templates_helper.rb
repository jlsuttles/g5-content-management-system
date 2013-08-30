module WebTemplatesHelper
  def preview(website, web_template)
    # get the web layout html
    html = Nokogiri.parse(website.website_template.web_layout.html)
    # put each widgets in its drop target in the web layout html
    web_template.all_widgets.group_by(&:html_id).each do |html_id, widgets|
      # find html element by id
      html_section = html.at_css("##{html_id}")
      if html_section
        widget_html = widgets.map(&:liquidized_html).join
        html_section.inner_html = widget_html
      end
    end
    # return the modified layout
    html.to_html
  end
end
