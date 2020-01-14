# ActiveRecord::Missing

Backport of `ActiveRecord::QueryMethods::WhereChain#missing` for Rails 6.0 and 5.x applications.  
https://github.com/rails/rails/pull/34727


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-missing'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install activerecord-missing

## Usage

``` ruby
Post.where.missing(:author)
Post.where.missing(:author, :comments)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yujideveloper/activerecord-missing.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
