require 'feedjira'

class FeedClient
  def fetch_and_parse(uri)
    feed = Feedjira::Feed.fetch_and_parse(uri)
    return [] if feed.is_a?(Fixnum)
    feed.entries
  end
end
