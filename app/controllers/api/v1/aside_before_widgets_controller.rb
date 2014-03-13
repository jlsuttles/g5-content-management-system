class Api::V1::AsideWidgetsController < Api::V1::WidgetsController
  private
  def klass
    "aside_before_widget"
  end
end
