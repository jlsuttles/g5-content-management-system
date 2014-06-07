class ColumnWidgetShowHtml
  attr_accessor :column_widget

  def initialize(column_widget)
    @column_widget = column_widget
  end

  def render
    show_html = Liquid::Template.parse(column_widget.show_html).render("widget" => column_widget)
    @nokogiri = Nokogiri.parse(show_html)

    render_widget("row_one_widget_id", "#drop-target-first-row")

    if two_rows? or three_rows? or four_rows?
      render_widget("row_two_widget_id", "#drop-target-second-row")

      if three_rows? or four_rows?
        render_widget("row_three_widget_id", "#drop-target-third-row")

        if four_rows?
          render_widget("row_four_widget_id", "#drop-target-fourth-row")
        end
      end
    end

    @nokogiri.to_html
  end

  private

  def row_count
    @row_count ||= column_widget.settings.where(name: "row_count").first.try(:value)
  end

  def two_rows?
    row_count == "two"
  end

  def three_rows?
    row_count == "three"
  end

  def four_rows?
    row_count == "four"
  end

  def find_widget(setting_name)
    id = column_widget.settings.where(name: setting_name).first.try(:value)
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

