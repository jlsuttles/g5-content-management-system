require "open-uri"

class RemoteJavascript
  def initialize(remote_path, js_dir=nil)
    @remote_path = remote_path
    @js_dir = js_dir
  end

  def js_dir
    @js_dir ||= File.join(Rails.root, "public", "javascripts")
  end

  def js_file_name
    @file_name ||= @remote_path.split("/").last
  end

  def js_file_path
    @js_file_path ||= File.join(js_dir, js_file_name)
  end

  def js_link_path
    @js_link_path ||= File.join("/javascripts", js_file_name)
  end

  def compile
    FileUtils.mkdir_p(js_dir)
    open(js_file_path, "wb") do |file|
      file << open(@remote_path).read
    end
    open(js_file_path).read
  end
end
