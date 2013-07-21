class Api::V1::FooterWidgetsController < Api::V1::WidgetsController
  private
  def klass
    "footer_widget"
  end

  def section
    Widget::FOOTER
  end
end
