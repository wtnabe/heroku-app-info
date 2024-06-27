require "yaml"

module HerokuAppInfo
  class Parser
    #
    # simple app list
    #
    # @param [String] apps
    # @return [Array]
    #
    def apps(apps)
      apps.lines(chomp: true).grep_v(/\A===/).map { |e|
        /\A([^ ]+)/ =~ e
        $1
      }.compact
    end

    #
    # @param [String] text
    # @return [Hash]
    #
    def parse(text)
      info = {}

      last_item = nil
      title = nil
      text.lines(chomp: true).each { |line|
        next if line.size < 1

        data = parse_line(line.rstrip)

        case data[:item]
        when :continuation
          info[last_item] << data[:content]
        when :title
          title = data[:content]
        else
          multi_item = app_multi_items.select { |item, type| item == data[:item] }
          if multi_item.size > 0
            case multi_item.values.first.to_s
            when "Array"
              info[data[:item]] = [data[:content]]
            when "Hash"
              info[data[:item]] = parse_hash_item(data[:content])
            end
          else
            info[data[:item]] = data[:content]
          end
        end
        last_item = data[:item] unless data[:item] == :continuation
      }

      info
    end

    #
    # @param [String] line
    # @return [Hash]
    #
    def parse_line(line)
      case line
      # title line
      when /\A=== (.+)\z/
        {
          item: :title,
          content: $1
        }
      # data line
      when /\A(?:([A-Z][^:]+):)?(?: +(.+))?\z/
        if !$1 && $2 # continuation
          {
            item: :continuation,
            content: $2
          }
        else # normal
          {
            item: $1,
            content: $2
          }
        end
      end
    end

    #
    # @param [String, nil] item
    # @return [Hash]
    #
    def parse_hash_item(item)
      if item.nil?
        {}
      else

        YAML.safe_load(item.split(",").map(&:strip).join("\n"))
      end
    end

    #
    # @return [Hash]
    #
    def app_multi_items
      {
        "Addons" => Array,
        "Collaborators" => Array,
        "Dynos" => Hash
      }
    end
  end
end
