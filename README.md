[![Gem Version](https://badge.fury.io/rb/cachers.svg)](http://badge.fury.io/rb/cachers)
[![Code Climate](https://codeclimate.com/github/museways/cachers/badges/gpa.svg)](https://codeclimate.com/github/museways/cachers)
[![Build Status](https://travis-ci.org/museways/cachers.svg)](https://travis-ci.org/museways/cachers)
[![Dependency Status](https://gemnasium.com/museways/cachers.svg)](https://gemnasium.com/museways/cachers)

# Cachers

Dedicated classes to isolate redis logic in rails.

## Why

We did this gem to:

- Prevent models to have too much code.
- Have a convention of how to use cache in models.
- Increase atomization in complex projects.

## Install

Put this line in your Gemfile:
```ruby
gem 'cachers'
```

Then bundle:
```
$ bundle
```

## Usage

### Definitions

Generate a cacher for a model:
```
$ bundle exec rails g cacher like
```

Add the logic to the cache and uncache methods:
```ruby
class LikeCacher < Cachers::Base

  def cache
    sadd key, record.product.id
  end

  def uncache
    srem key, record.product.id
  end

  private

  def key
    "users/#{record.user.id}/likes"
  end

end
```

NOTE: Updates work automatically, there is no need to add a method to replace values.

### Custom methods

You may want to add some other methods related to the cache:
```ruby
class UserCacher < Cachers::Base

  def likes?(product)
    sismember key, product.id
  end

  private

  def key
    "users/#{record.id}/likes"
  end

end
```

The public methods will be available to call directly from the model:
```ruby
user.likes? product
```

### Cache management

If you want to manually control the cache, you can use this methods:
```ruby
user.cache
user.recache
user.uncache
```

Or to it for all cacheable records:
```
$ bundle exec rake cachers:cache
$ bundle exec rake cachers:recache
$ bundle exec rake cachers:uncache
```

## Contributing

Any issue, pull request, comment of any kind is more than welcome!

We will mainly ensure compatibility to Rails, AWS, PostgreSQL, Redis, Elasticsearch and FreeBSD. 

## Credits

This gem is maintained and funded by [museways](https://github.com/museways).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
