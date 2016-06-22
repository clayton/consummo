require 'spec_helper'

describe 'Persisting Items' do
  before(:each) do
    @feed = Feed.create(uri: "http://feeds.feedburner.com/FreeBeacon", title: "FreeBeacon")
  end
  xit 'should produce, consume and persist FeedItems' do
    # Find a non AR way to describe this behavior
  end
end
