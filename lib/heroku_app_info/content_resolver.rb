module HerokuAppInfo
  class ContentResolver
    #
    # @param [String] name
    # @param [String, Hash] info
    # @param [String, nil] sort
    # @return [Array] filename, content
    #
    def self.resolve(name, info, sort: nil)
      ext = info.is_a?(String) ? ".txt" : ".json"

      [
        [name, sort].compact.join("_") + ext,
        if info.is_a?(String)
          info
        else
          JSON.generate(info)
        end
      ]
    end
  end
end
