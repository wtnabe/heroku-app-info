# frozen_string_literal: true

require_relative "lib/heroku_app_info/version"

Gem::Specification.new do |spec|
  spec.name = "heroku-app-info"
  spec.version = HerokuAppInfo::VERSION
  spec.authors = ["wtnabe"]
  spec.email = ["18510+wtnabe@users.noreply.github.com"]

  spec.summary = "Gather and Store Heroku App infos."
  spec.description = "store Application Stack, PotgsreSQL version, etc. mainly for upgrade management."
  spec.homepage = "https://github.com/wtnabe/heroku-app-info"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/wtnabe/heroku-app-info"
  spec.metadata["changelog_uri"] = "https://github.com/wtnabe/heroku-app-info/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "tty-which", "~> 0.5.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
