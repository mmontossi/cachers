[![Gem Version](https://badge.fury.io/rb/cachers.svg)](http://badge.fury.io/rb/cachers)
[![Code Climate](https://codeclimate.com/github/mmontossi/cachers/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/cachers)
[![Build Status](https://travis-ci.org/mmontossi/cachers.svg)](https://travis-ci.org/mmontossi/cachers)
[![Dependency Status](https://gemnasium.com/mmontossi/cachers.svg)](https://gemnasium.com/mmontossi/cachers)

# Cachers

Extracts models cache logic into separate classes in rails.


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

Work with your model as usual and you want to cache some part generate a cacher like this:
```
bundle exec rails g cacher like
```

Add the logic to the cache and uncache methods:
```ruby
class LikeCacher < Cachers::Base

  def cache
    $redis.sadd users_key, record.product.id
    $redis.sadd products_key, record.user.id
  end

  def uncache
    $redis.srem users_key, record.product.id
    $redis.srem products_key, record.user.id
  end

  private

  def users_key
    "users/#{record.user.id}/likes"
  end

  def products_key
    "products/#{record.product.id}/likes"
  end

end
```

NOTE: Updates happen automagically, no need to add another method.

## Contributing

Because we've limited resources we'll mainly add features and keep a compatibility range close to what we need in our projects. However, contributions are more than welcome if someone wants to make any improvement.

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
