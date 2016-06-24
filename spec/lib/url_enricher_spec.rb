require 'spec_helper'

describe 'URL Enrichment' do
  it 'should accept an item' do
    sut = Consummo::UrlEnricher.new
    sut.enrich(Consummo::SimpleItem.new)
  end

  it 'should tell the url resolver to resolve the final url' do
    resolver = Consummo::DummyUrlResolver.new
    sut = Consummo::UrlEnricher.new(resolver: resolver)

    expect(resolver).to receive(:resolve).with("http://www.example.com")
    sut.enrich(Consummo::SimpleItem.new(url: "http://www.example.com"))
  end

  it 'should return the url for replacement' do
    resolver = StubbedUrlResolver.new("http://example.com")
    sut = Consummo::UrlEnricher.new(resolver: resolver)
    result = sut.enrich(Consummo::SimpleItem.new(url: "http://redirector.example.com/1/2/3/4"))
    expect(result).to eq({url: "http://example.com"})
  end
end

class Consummo::DummyUrlResolver
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
