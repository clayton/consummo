require 'spec_helper'

describe Consummo::ItemProducer do
  it 'should accept feeds' do
    Consummo::ItemProducer.new(feeds: [Consummo::Feed.new])
  end

  it 'should be able to produce new feed items' do
    Consummo::ItemProducer.new.produce()
  end

  context 'Fetching Feed Items' do
    it 'should tell the feed fetcher to fetch feed items' do
      feed = Consummo::Feed.new
      fetcher = Consummo::DummyFetcher.new

      sut = Consummo::ItemProducer.new(feeds: [feed], fetcher: fetcher)
      expect(fetcher).to receive(:fetch).with(feed)
      sut.produce
    end
  end
end

class Consummo::DummyFetcher < Consummo::FeedFetcher
  def fetch(feed)

  end
end

class StubbedFetcher < Consummo::FeedFetcher
  def fetch(feed)
    [SimpleItem.new, SimpleItem.new]
  end
end
