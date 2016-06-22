require 'spec_helper'

describe 'URL Enrichment' do
  it 'should accept an item' do
    sut = UrlEnricher.new
    sut.enrich(SimpleItem.new)
  end

  it 'should tell the url resolver to resolve the final url' do
    resolver = DummyUrlResolver.new
    sut = UrlEnricher.new(resolver: resolver)

    expect(resolver).to receive(:resolve).with("http://www.example.com")
    sut.enrich(SimpleItem.new(url: "http://www.example.com"))
  end

  it 'should return the url for replacement' do
    resolver = StubbedUrlResolver.new("http://example.com")
    sut = UrlEnricher.new(resolver: resolver)
    result = sut.enrich(SimpleItem.new(url: "http://redirector.example.com/1/2/3/4"))
    expect(result).to eq({url: "http://example.com"})
  end
end

class DummyUrlResolver
  def resolve(url=nil)
    url
  end
end

class StubbedUrlResolver
  def initialize(stub=nil)
    @stub = stub
  end
  def resolve(url)
    @stub
  end
end
