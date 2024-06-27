require_relative "content_resolver"
require "tty-which"

#
# require Heroku-cli
#

module HerokuAppInfo
  class Fetcher
    #
    # @param [Options] options
    #
    def initialize(options = nil)
      @options = options
      raise HerokuCliNotFound if TTY::Which.which("heroku").nil?
    end

    #
    # @param [String] app
    # @return [String]
    #
    def app(app)
      if (path = cache_file(app: app))
        File.read(path)
      else
        `heroku apps:info #{app}`
      end
    end

    #
    # @param [String] app
    # @return [String]
    #
    def pg(app)
      if (path = cache_file(app: app, sort: "pg"))
        File.read(path)
      else
        `heroku pg -a #{app}`
      end
    end

    #
    # @param [String] app
    # @return [String]
    #
    def addons(app)
      if (path = cache_file(app: app))
        File.read(path)
      else
        `heroku addons -a #{app}`
      end
    end

    #
    # @return [String]
    #
    def all_apps
      if (path = cache_file)
        File.read(path)
      else
        `heroku apps -A`
      end
    end

    #
    # @param [String] app
    # @param [String] sort
    # @return [String, false]
    #
    def cache_file(app: nil, sort: nil)
      return false if @options.no_cache?

      filename, = ContentResolver.resolve(app || "apps", "", sort: sort)
      path = File.join(@options.out_dir, filename)

      (File.exist?(path) && File.readable?(path)) ? path : false
    end
  end
end
