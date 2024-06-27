require_relative "content_resolver"
require "json"

module HerokuAppInfo
  class Writer
    #
    # @param [Options] options
    #
    def initialize(options)
      @options = options
    end

    #
    # @param [String] app
    # @param [String, Hash] info
    # @param [String, nil] sort
    # @return [Integer]
    #
    def write(app, info, sort: nil)
      filename, content = ContentResolver.resolve(app, info, sort: sort)

      File.write(File.join(@options.out_dir, filename), content)
    end
  end
end
