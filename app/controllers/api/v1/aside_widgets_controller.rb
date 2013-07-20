class Api::V1::AsideWidgetsController < Api::V1::WidgetsController
  private
  def section
    Widgets::ASIDE
  end
end
