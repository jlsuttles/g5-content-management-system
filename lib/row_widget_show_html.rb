class RowWidgetShowHtml
  attr_accessor :row_widget, :nokogiri

  def initialize(row_widget)
    @row_widget = row_widget
  end

  def render
    show_html = Liquid::Template.parse(row_widget.show_html).render("widget" => row_widget)
    @nokogiri = Nokogiri.parse(show_html)
    render_column_one_widget
    if two_columns? or three_columns? or four_columns?
      render_column_two_widget
      if three_columns? or four_columns?
        render_column_three_widget
        if four_columns?
          render_column_four_widget
        end
      end
    end
    nokogiri.to_html
  end

  def row_layout
    @row_layout ||= row_widget.settings.where(name: "row_layout").first.try(:value)
  end

  def two_columns?
    row_layout == "halves"
  end

  def three_columns?
    row_layout == "thirds-1" || row_layout == "thirds-2" || row_layout == "thirds"
  end

  def four_columns?
    row_layout == "quarters"
  end

  def column_one_widget
    id = row_widget.settings.where(name: "column_one_widget_id").first.try(:value)
    Widget.where(id: id).first if id
  end

  def column_two_widget
    id = row_widget.settings.where(name: "column_two_widget_id").first.try(:value)
    Widget.where(id: id).first if id
  end

  def column_three_widget
    id = row_widget.settings.where(name: "column_three_widget_id").first.try(:value)
    Widget.where(id: id).first if id
  end

  def column_four_widget
    id = row_widget.settings.where(name: "column_four_widget_id").first.try(:value)
    Widget.where(id: id).first if id
  end

  def render_column_one_widget
    if column_one_widget
      column_one = nokogiri.at_css("#drop-target-first-col")
      column_one.inner_html = column_one_widget.render_show_html
    end
  end

  def render_column_two_widget
    if column_two_widget
      column_two = nokogiri.at_css("#drop-target-second-col")
      column_two.inner_html = column_two_widget.render_show_html
    end
  end

  def render_column_three_widget
    if column_three_widget
      column_three = nokogiri.at_css("#drop-target-third-col")
      column_three.inner_html = column_three_widget.render_show_html
    end
  end

  def render_column_four_widget
    if column_four_widget
      column_four = nokogiri.at_css("#drop-target-fourth-col")
      column_four.inner_html = column_four_widget.render_show_html
    end
  end
end
