# Consummo

[![Build Status](http://img.shields.io/travis/clayton/consummo.svg?style=flat-square)](https://travis-ci.org/clayton/consummo)
[![Dependency Status](http://img.shields.io/gemnasium/clayton/consummo.svg?style=flat-square)](https://gemnasium.com/clayton/consummo)
[![Code Climate](http://img.shields.io/codeclimate/github/clayton/consummo.svg?style=flat-square)](https://codeclimate.com/github/clayton/consummo)
[![Test Coverage](https://codeclimate.com/github/clayton/consummo/badges/coverage.svg)](https://codeclimate.com/github/clayton/consummo/coverage)
[![Issue Count](https://codeclimate.com/github/clayton/consummo/badges/issue_count.svg)](https://codeclimate.com/github/clayton/consummo)
[![Gem Version](http://img.shields.io/gem/v/consummo.svg?style=flat-square)](https://rubygems.org/gems/consummo)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://clayton.mit-license.org)

Consummo is an engine for consuming, enriching and producing pieces of content from RSS feeds.

## Quick Start

```ruby

  # Create a Feed
  feed = Feed.new(uri: "http://feedjira.com/blog/feed.xml")

  # Produce Items from the feed
  items = ItemProducer.new(feeds: [feed]).produce
  # items => [SimpleItem, SimpleItem, SimpleItem]

  # define our content enrichers
  enrichers = [FacebookLikeEnricher.new]

  # Consume items
  enriched_items = ItemConsumer.new(items: items, enrichers: enrichers).consume
  # enriched_items => [SimpleItem, SimpleItem, SimpleItem]

```

## Using with Rails

If you're using consummo with rails, you'll probably want to create `ActiveRecord` backed objects for:

- `FeedItem`
- `Feed`

When producing and consuming `FeedItems` you'll probably want to persist them to a datastore when producing and/or consuming.

## The Consummo Domain

### Feeds
A `Feed` is a simple data structure that represents a URI feed. It has a `uri` attribute.

### Feed Items
A `Feed Item` represents a singular piece of content produced from a `Feed`. It has attributes like `title` and `url`.

### Producers
An `Item Producer` takes a list of `Feeds` along with a `Fetcher` and fetches items from the feed.

### Consumers
An `Item Consumer` takes unenriched `Feed Items` and passes them through `Item Enrichers`.

### Item Enricher
An `Item Enricher` enriches the details and data from a `Feed Item`. For example, the `FacebookLikeEnricher` will determine the number of Facebook Likes for a particular `Feed Item` (using the item's url) and add that attribute to the `Feed Item`.

The intent of `Item Enrichers` is that they are extensible and easy to implement such that multiple custom enrichments are possible.

## Custom Enrichment

Enrichers follow a very simple interface:

```ruby
  class SimpleEnricher
    def enrich(item)
      { "simple" => "enrichment" }
    end
  end
```

An Enricher should be able to `enrich` something that looks like an `item` (`SimpleItem`) and return a hash of key/value pairs.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'consummo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install consummo

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/clayton/consummo.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
