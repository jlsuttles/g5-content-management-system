require "static_website/compiler"

module StaticWebsite
  class Deployer
    attr_reader :website, :compile_path, :retries

    def initialize(website)
      @website = website
      @compile_path = website.compile_path
      @retries = 0
    end

    def deploy
      @retries = 0
      begin
        deployer.deploy(deployer_options) do |repo|
          cp_r_compile_path(repo)
        end
      rescue GithubHerokuDeployer::CommandException,
             Heroku::API::Errors::ErrorWithResponse => e
        if should_retry?
          increment_retries
          retry
        else
          raise e
        end
      ensure
        clean_up
      end
    end

    def deployer
      @deployer ||= GithubHerokuDeployer
    end

    def deployer_options
      { github_repo: @website.github_repo,
        heroku_app_name: @website.heroku_app_name,
        heroku_repo: @website.heroku_repo }
    end

    def cp_r_compile_path(repo)
      # save repo dir so we can remove it later
      @repo_dir = repo.dir.to_s
      # copy static website into repo
      `cp -r #{compile_path}/* #{repo.dir}`
      # copy public javascripts into repo
      `cp #{File.join(Rails.root, "public", "javascripts")}/* #{repo.dir}/javascripts/`
      # commit changes
      repo.add('.')
      repo.commit_all "Add compiled site"
    end

    def should_retry?
      @retries < 3
    end

    def increment_retries
      @retries += 1
    end

    def clean_up
      FileUtils.rm_rf(@repo_dir) if @repo_dir && Dir.exists?(@repo_dir)
    end
  end
end
