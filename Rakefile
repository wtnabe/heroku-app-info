# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "yard"

Rake::TestTask.new(:spec) do |t|
  t.libs << "spec"
  t.libs << "lib"
  t.test_files = FileList["spec/**/*_spec.rb"]
end

require "standard/rake"

YARD::Rake::YardocTask.new do |t|
  t.files = [
    "exe/*",
    "lib/**/*.rb"
  ]
end

task default: %i[spec standard]
