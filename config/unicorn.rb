# Unicorn forks multiple OS processes within each dyno to allow a Rails app to
# support multiple concurrent requests without requiring them to be
# thread-safe. In Unicorn terminology these are referred to as worker
# processes not to be confused with Heroku worker processes which run in their
# own dynos.
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)

# Heroku’s router enforces a 30 second window before there is a request
# timeout. After a request is delivered to a dyno via the router it has 30
# seconds to return a response or the router will return a customizable error
# page. This is done to prevent hanging requests from tying up resources. While
# the router will return a response to the client, the unicorn worker will
# continue to process the request even though a client has received a response.
# This means that the worker is being tied up, perhaps indefinitely due to a
# hung request.
timeout 15

# Preloading your application reduces the startup time of individual Unicorn
# worker_processes and allows you to manage the external connections of each
# individual worker using the before_fork and after_fork calls.
# New Relic also recommends preload_app true for more accurate data collection
# with Unicorn apps.
preload_app true

before_fork do |server, worker|
  # POSIX Signals are a form of interprocess communication to indicate a
  # certain event or state change. Traditionally, QUIT is used to signal a
  # process to exit immediately and produce a core dump. TERM is used to tell a
  # process to terminate, but allows the process to clean up after itself.
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  if defined?(Resque)
    Resque.redis.quit
    Rails.logger.info('Disconnected from Redis')
  end
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  if defined?(Resque)
    Resque.redis = ENV["REDISTOGO_URL"] if ENV["REDISTOGO_URL"]
    Resque.redis ||= ENV["REDISCLOUD_URL"] if ENV["REDISCLOUD_URL"]
    Rails.logger.info('Connected to Redis')
  end
end
