module WebTemplatesHelper
  def preview(web_layout, web_template)
    # get the web layout html
    html = Nokogiri.parse(web_layout.html)
    # put each widgets in its drop target in the web layout html
    web_template.all_widgets.group_by(&:html_id).each do |html_id, widgets|
      # find html element by id
      html_section = html.at_css("##{html_id}")
      if html_section
        if html_id == "drop-target-main" && !web_template.web_home_template?
          # put page title in h1 tag at top of main drop target
          inner_html = "<h1>#{web_template.title}</h1>"
        else
          inner_html =""
        end
        inner_html += widgets.map(&:liquidized_html).join
        html_section.inner_html = inner_html
      end
    end
    # return the modified layout
    html.to_html
  end

  def head_widgets(web_template)
    web_template.head_widgets.map(&:liquidized_html).join
  end
end
