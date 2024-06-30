require "optparse"

module HerokuAppInfo
  class Options
    #
    # @param [Array] argv
    #
    def initialize(argv)
      defaults!
      @parser = cli_parser
      @rest = @parser.parse(argv)
    end
    attr_reader :apps, :out_dir, :authz, :rest

    #
    # @return [Boolean]
    #
    def show_all?
      @show_all
    end

    #
    # @return [Boolean]
    #
    def no_cache?
      @no_cache
    end

    def raw_output?
      @raw_output
    end

    def defaults!
      @out_dir = Dir.pwd
    end

    def help
      @parser.help
    end

    #
    # @return [OptionParser]
    #
    def cli_parser
      OptionParser.new do |opt|
        opt.on("-a", "--app-list APP,APP,APP") do |apps|
          @apps = apps.split(",")
        end
        opt.on("--app-list-from FILE") do |file|
          if File.exist?(file) && File.readable?(file)
            @apps = File.read(file).lines(chomp: true)
          end
        end
        opt.on("-n", "--no-cache") do
          @no_cache = true
        end
        opt.on("-o", "--out-dir [DIR]") do |dir|
          if File.exist?(dir) && File.directory?(dir) && File.writable?(dir)
            @out_dir = dir
          end
        end
        opt.on("-r", "--raw-output") do
          @raw_output = true
        end
        opt.on("-s", "--show-all-apps", "not include detail") do
          @show_all = true
        end
        opt.on("-z", "--authorizarion AUTH") do |auth|
          @authz = auth
        end

        opt.version = VERSION
      end
    end
  end
end
