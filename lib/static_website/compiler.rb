require "static_website/compiler/website"

module StaticWebsite::Compiler
  def self.new(website)
    StaticWebsite::Compiler::Website.new(website)
  end
end
