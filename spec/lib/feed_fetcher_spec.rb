require 'spec_helper'

describe 'FeedFetcher' do
  it 'should use an http client' do
    feed = Consummo::Feed.new(uri: "http://example.com/rss")
    client = Consummo::DummyFeedClient.new
    expect(client).to receive(:fetch_and_parse).with("http://example.com/rss") {[]}
    Consummo::FeedFetcher.new(client: client).fetch(feed)
  end

  context 'Fetching Items' do
    context "when the feed has an invalid uri" do
      xit "should not try and fetch the feed" do
      end
    end
    context "when the feed has a valid uri" do
      it 'should tell the ItemFactory to build items from entries' do
        feed   = Consummo::Feed.new(uri: "http://example.com/rss")
        entry  = Consummo::DummyRssEntry.new
        client = Consummo::StubbedFeedClient.new([entry])
        item_factory = Consummo::FeedItemFactory.new
        expect(item_factory).to receive(:build).with(entry) {Consummo::SimpleItem.new}
        results = Consummo::FeedFetcher.new(client: client, factory: item_factory).fetch(feed)
      end

      context 'when the feed has already been fetched once' do
        before(:each) do
          @stub_items = [
            Consummo::DummyRssEntry.new(last_modified: Time.parse('3000-07-24 15:00:02 UTC')),
            Consummo::DummyRssEntry.new(last_modified: Time.parse('2000-07-24 15:00:02 UTC')),
            Consummo::DummyRssEntry.new(last_modified: Time.parse('1000-07-24 15:00:02 UTC'))
          ]
        end
        it 'should reject known items' do
          feed   = Consummo::Feed.new(uri: "http://example.com/rss", id: 1999)
          client = Consummo::StubbedFeedClient.new(@stub_items)
          results = Consummo::FeedFetcher.new(client: client).fetch(feed, Time.now)
          expect(results.size).to eq 1
        end
      end
    end
  end
end

class Consummo::DummyFeedClient < Consummo::FeedClient
  def fetch_and_parse(uri)
    []
  end

  def update(uri, last_entry)
    []
  end
end

class Consummo::StubbedFeedClient < Consummo::FeedClient
  def initialize(stub=nil)
    @stub = stub || [Feedjira::Parser::AtomEntry.new, Feedjira::Parser::AtomEntry.new]
  end
  def fetch_and_parse(feed)
    @stub
  end
end

class Consummo::DummyRssEntry < Feedjira::Parser::AtomEntry
  attr_accessor :last_modified
end
