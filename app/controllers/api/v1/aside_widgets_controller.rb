class Api::V1::AsideWidgetsController < Api::V1::WidgetsController
  private
  def klass
    "aside_widget"
  end

  def section
    Widget::ASIDE
  end
end
