module HerokuAppInfo
  class Error < ::StandardError; end
  class HerokuCliNotFound < Error; end # standard:disable Layout/EmptyLineBetweenDefs
end

Dir.glob("#{File.dirname(__FILE__)}/heroku_app_info/**/*.rb").sort.each { |f| require f }
