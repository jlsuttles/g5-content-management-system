class Api::V1::LogoWidgetsController < Api::V1::WidgetsController
  private
  def section
    Widgets::LOGO
  end
end
