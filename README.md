[![Gem Version](https://badge.fury.io/rb/cachers.svg)](http://badge.fury.io/rb/cachers)
[![Code Climate](https://codeclimate.com/github/mmontossi/cachers/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/cachers)
[![Build Status](https://travis-ci.org/mmontossi/cachers.svg)](https://travis-ci.org/mmontossi/cachers)
[![Dependency Status](https://gemnasium.com/mmontossi/cachers.svg)](https://gemnasium.com/mmontossi/cachers)

# Cachers

Dedicated classes to abstract cache logic in rails.

## Why

I did this gem to:

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

## Configuration 

Work with your models as usual and if you want to cache something generate a cacher like this:
```
$ bundle exec rails g cacher like
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
NOTE: Updates work automatically when records are saved, there is no need to add a method to replace values.

## Usage

If you need to manually cache, recache, or uncache a record:
```ruby
like.cache
like.recache
like.uncache
```

You probably want to add some other methods related to the cache:
```ruby
class UserCacher < Cachers::Base

  def likes?(product)
    $redis.sismember key, product.id
  end

  private

  def key
    "users/#{record.id}/likes"
  end

end
```

Those methods will be available within the cacher attribute:
```ruby
user.cacher.likes? product
```

NOTE: If you prefer, you can delegate the methods in the model to avoid typing cacher every time.

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
