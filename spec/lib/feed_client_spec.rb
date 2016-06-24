require 'spec_helper'

describe 'FeedClient' do
  it 'should exist' do
    Consummo::FeedClient.new
  end

  xit 'should fetch and parse a feed' do
    Consummo::FeedClient.new.fetch_and_parse("http://feeds.washingtonpost.com/rss/politics")
  end

end
