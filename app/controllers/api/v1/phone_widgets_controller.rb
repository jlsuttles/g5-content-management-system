class Api::V1::PhoneWidgetsController < Api::V1::WidgetsController
  private
  def section
    Widgets::PHONE
  end
end
