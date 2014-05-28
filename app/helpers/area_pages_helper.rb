module AreaPagesHelper
  def area_preview(web_layout, web_template, locations, area)
    html = base_html(web_layout, web_template)
    html_section = html.at_css("#drop-target-main")
    html_section.inner_html = render_locations(locations, area)

    html.to_html
  end

  def canonical_link_element(params, web_template)
    url = File.join(web_template.send(:domain_for_type), query(params))
    "<link rel='canonical' href='#{url}' />"
  end

private

  def render_locations(locations, area)
    string = "<h1>Locations in #{area}</h1>"

    locations.each do |location|
      string += "<p><a href='#{location.website.decorate.heroku_url}'>" \
                        "#{location.name}</a></p>"
    end

    string
  end

  def query(params)
    [params[:state], params[:city], params[:neighborhood]].reject(&:blank?).join("/")
  end
end
