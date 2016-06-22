class FeedFetcher
  def initialize(client: FeedClient.new, factory: FeedItemFactory.new)
    @client  = client
    @factory = factory
  end

  def fetch(feed, last_modified = nil)
    @client.fetch_and_parse(feed.uri).map do |entry|
      next if old_entry?(entry, last_modified)
      item = @factory.build(entry)
      item.attributes = {:feed_id => feed.id}

      item
    end.compact
  end

private
  def old_entry?(entry, last_modified)
    return false if last_modified.nil?
    last_modified > entry.last_modified
  end
end
