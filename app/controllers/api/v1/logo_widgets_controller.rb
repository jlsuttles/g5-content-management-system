class Api::V1::LogoWidgetsController < Api::V1::WidgetsController
  private
  def klass
    "logo_widget"
  end

  def section
    Widget::LOGO
  end
end
