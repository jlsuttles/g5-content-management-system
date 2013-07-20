class Api::V1::NavWidgetsController < Api::V1::WidgetsController
  private
  def section
    Widgets::NAV
  end
end
