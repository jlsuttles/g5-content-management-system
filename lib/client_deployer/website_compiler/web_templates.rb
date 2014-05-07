require "client_deployer/website_compiler/web_template"

module ClientDeployer
  module WebsiteCompiler
    class WebTemplates
      attr_reader :web_template_models

      def initialize(web_template_models)
        @web_template_models = web_template_models
      end

      def compile
        web_template_models.each do |web_template_model|
          compile_web_template(web_template_model)
        end if web_template_models
      end

      def compile_web_template(web_template_model)
        WebTemplate.new(web_template_model).compile
      end
    end
  end
end
