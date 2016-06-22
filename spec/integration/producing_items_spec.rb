require 'spec_helper'

describe 'Item Producer Integration' do
  it 'should produce a list of feed items' do
    VCR.use_cassette("simple_feed_fetching") do
      feed = Feed.new(uri: "http://feedjira.com/blog/feed.xml")
      results = ItemProducer.new(feeds: [feed]).produce

      results.each do |result|
        expect(result).to be_a SimpleItem
      end
    end
  end
end
