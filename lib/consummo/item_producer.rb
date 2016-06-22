class ItemProducer
  def initialize(feeds: [], fetcher: FeedFetcher.new)
    @feeds = feeds
    @fetcher = fetcher
  end

  def produce
    @feeds.flat_map do |feed|
      @fetcher.fetch(feed)
    end.shuffle
  end
end
