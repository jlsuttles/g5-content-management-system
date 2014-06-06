class RowWidgetShowHtml
  attr_accessor :row_widget

  def initialize(row_widget)
    @row_widget = row_widget
  end

  def render
    show_html = Liquid::Template.parse(row_widget.show_html).render("widget" => row_widget)
    @nokogiri = Nokogiri.parse(show_html)
    render_widget("column_one_widget_id", "#drop-target-first-col")
    if two_columns? or three_columns? or four_columns?
      render_widget("column_two_widget_id", "#drop-target-second-col")
      if three_columns? or four_columns?
        render_widget("column_three_widget_id", "#drop-target-third-col")
        if four_columns?
          render_widget("column_four_widget_id", "#drop-target-fourth-col")
        end
      end
    end
    @nokogiri.to_html
  end

  private

  def row_layout
    @row_layout ||= row_widget.settings.where(name: "row_layout").first.try(:value)
  end

  def two_columns?
    row_layout == "halves"|| row_layout == "uneven-thirds-1" || row_layout == "uneven-thirds-2"
  end

  def three_columns?
    row_layout == "thirds"
  end

  def four_columns?
    row_layout == "quarters"
  end

  def find_widget(setting_name)
    id = row_widget.settings.where(name: setting_name).first.try(:value)
    Widget.where(id: id).first if id
  end

  def render_widget(setting_name, html_id)
    if widget = find_widget(setting_name)
      html_at_id = @nokogiri.at_css(html_id)
      if html_at_id
        html_at_id.inner_html = widget.render_show_html
      end
    end
  end
end
