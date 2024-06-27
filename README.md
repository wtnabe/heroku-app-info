# HerokuAppInfo

Provides the ability to list Heroku apps that can be accessed by your account, to retrieve detailed information about each app, database version, and other information, and to store this as JSON.

It is primarily intended to be used for creating maintenance plans for Stack and others.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add heroku-app-info

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install heroku-app-info

And, at the moment it depends on the Heroku CLI.

[The Heroku CLI \| Heroku Dev Center](https://devcenter.heroku.com/articles/heroku-cli)

## Usage

```
$ heroku-app-info -h
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wtnabe/heroku-app-info.
