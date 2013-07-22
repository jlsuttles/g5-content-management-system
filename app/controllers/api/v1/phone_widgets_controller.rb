class Api::V1::PhoneWidgetsController < Api::V1::WidgetsController
  private
  def klass
    "phone_widget"
  end

  def section
    Widget::PHONE
  end
end
