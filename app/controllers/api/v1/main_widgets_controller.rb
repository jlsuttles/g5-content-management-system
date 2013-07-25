class Api::V1::MainWidgetsController < Api::V1::WidgetsController
  private
  def klass
    "main_widget"
  end

  def section
    Widget::MAIN
  end
end
