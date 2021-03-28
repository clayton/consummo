require 'spec_helper'

describe 'Item Producer Integration' do
  it 'should produce a list of feed items' do
    VCR.use_cassette("simple_feed_fetching") do
      feed = Consummo::Feed.new(uri: "https://rss.art19.com/apology-line")
      results = Consummo::ItemProducer.new(feeds: [feed]).produce

      results.each do |result|
        expect(result).to be_a Consummo::SimpleItem
      end
    end
  end
end
