require 'spec_helper'

describe 'Feed Item Factory' do
  it 'should build items' do
    sut = Consummo::FeedItemFactory.new
    sut.build(Consummo::DummyRssEntry.new)
  end

  context 'When the published attribute is busto' do
    it 'should sanitize the time stamp' do
      bad_entry = Consummo::DummyRssEntry.new(:published => "-0001-11-30 00:00:00")
      sut = Consummo::FeedItemFactory.new()
      result = sut.build(bad_entry)
      expect(result.attributes[:published_at]).to_not eq "-0001-11-30 00:00:00"
    end
  end
end

class Consummo::DummyRssEntry < Feedjira::Parser::AtomEntry
  attr_accessor :last_modified, :published
end
