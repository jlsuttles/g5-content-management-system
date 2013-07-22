class Api::V1::BtnWidgetsController < Api::V1::WidgetsController
  private
  def klass
    "btn_widget"
  end

  def section
    Widget::BTN
  end
end
