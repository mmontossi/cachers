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

Work with your models as usual and if you want to cache something generate a cacher like this:
```
bundle exec rails g cacher like
```

Add the logic to the cache and uncache methods:
```ruby
class LikeCacher < Cachers::Base

  def cache
    $redis.sadd key, record.product.id
  end

  def uncache
    $redis.srem key, record.product.id
  end

  private

  def key
    "users/#{record.user.id}/likes"
  end

end
```

You may like to delegate some methods directly to the cacher:
```ruby
class User < ActiveRecord::Base

  ...

  delegate :likes?, to: :cacher

end

class UserCacher < Cachers::Base

  ...

  def likes?(product)
    $redis.sismember key, product.id
  end

  private

  def key
    "users/#{record.id}/likes"
  end

end
```

NOTE: Updates work automagically when records are saved, there is no need to add a recache method to replace values.

## Contributing

Because we've limited resources we'll mainly add features and keep a compatibility range close to what we need in our projects. However, contributions are more than welcome if someone wants to make any improvement.

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
