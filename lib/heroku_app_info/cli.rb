require_relative "fetcher"
require_relative "options"
require_relative "parser"
require_relative "writer"

module HerokuAppInfo
  class Cli
    def initialize(root:)
      @root = root
    end
    attr_reader :root

    def execute
      @options = Options.new(ARGV.dup)

      set_authz! if @options.authz

      @fetcher = Fetcher.new(@options)
      @parser = Parser.new
      if @options.show_all?
        show_all_apps
      else
        apps =
          if @options.apps.nil?
            @parser.apps(@fetcher.all_apps)
          else
            @options.apps
          end
        dump_app_and_pg_details(apps)
      end
    end

    #
    # set API KEY to Environment Variable
    #
    # Currently, Heroku Account require MFA, so the login and password method is not supported
    #
    def set_authz!
      ENV["HEROKU_API_KEY"] = @options.authz
    end

    #
    # show all apps
    #
    def show_all_apps
      puts @fetcher.all_apps
    end

    #
    # dump each app and pg info
    #
    def dump_app_and_pg_details(apps)
      writer = Writer.new(@options)

      apps.each { |app|
        raw_app = @fetcher.app(app)
        writer.write(app, raw_app) if @options.raw_output?
        app_info = @parser.parse(raw_app)
        if has_pg?(app_info)
          raw_db = @fetcher.pg(app)
          writer.write(app, raw_db, sort: "pg") if @options.raw_output?
          db_info = @parser.parse(raw_db)
          writer.write(app, db_info, sort: "pg")
        end
        writer.write(app, app_info)
      }
    end

    #
    # @param [Hash] app_info
    # @return [Boolean]
    #
    def has_pg?(app_info)
      app_info.has_key?("Addons") && app_info["Addons"].grep(/postgresql/).size > 0
    end
  end
end
