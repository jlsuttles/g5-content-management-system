class Api::V1::FooterWidgetsController < Api::V1::WidgetsController
  private
  def section
    Widgets::FOOTER
  end
end
