module WebTemplatesHelper
  def preview(web_layout, web_template)
    # get the web layout html
    html = Nokogiri.parse(web_layout.html)
    # put each widgets in its drop target in the web layout html
    web_template.all_widgets.group_by(&:html_id).each do |html_id, widgets|
      # find html element by id
      html_section = html.at_css("##{html_id}")
      if html_section
        inner_html = widgets.map(&:liquidized_html).join
        html_section.inner_html = inner_html
      end
    end
    # return the modified layout
    html.to_html
  end

  def head_widgets(web_template)
    web_template.head_widgets.map(&:liquidized_html).join
  end

  def meta_description_widgets(web_template)
    web_template.meta_description_widgets.map(&:liquidized_html).join
  end
end
