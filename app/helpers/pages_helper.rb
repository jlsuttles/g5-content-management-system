module PagesHelper
  
  def preview(page)
    html = page.layout.html
    widgets = page.widgets.map(&:html)
    html.gsub("<p>Main Column</p>", widgets.join)
  end
end
