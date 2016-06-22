require 'spec_helper'

describe ItemProducer do
  it 'should accept feeds' do
    ItemProducer.new(feeds: [Feed.new])
  end

  it 'should be able to produce new feed items' do
    ItemProducer.new.produce()
  end

  context 'Fetching Feed Items' do
    it 'should tell the feed fetcher to fetch feed items' do
      feed = Feed.new
      fetcher = DummyFetcher.new

      sut = ItemProducer.new(feeds: [feed], fetcher: fetcher)
      expect(fetcher).to receive(:fetch).with(feed)
      sut.produce
    end
  end
end

class DummyFetcher < FeedFetcher
  def fetch(feed)

  end
end

class StubbedFetcher < FeedFetcher
  def fetch(feed)
    [SimpleItem.new, SimpleItem.new]
  end
end
