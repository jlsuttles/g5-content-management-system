module UrlEncode
  def url_encode(input)
    URI::encode(input) if input
  end
end
