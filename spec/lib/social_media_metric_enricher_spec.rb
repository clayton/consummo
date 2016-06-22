require 'spec_helper'

describe 'SocialMediaMetricEnricher' do
  it 'should get metrics for a uri' do
    http_client = DummyHttpClient.new
    item = SimpleItem.new(url: "http://example.com")
    sut = SocialMediaMetricEnricher.new(client: http_client)
    expect(http_client).to receive(:get).with("http://example.com?id=http://example.com") { {} }
    sut.enrich(item)
  end

  it 'should expose the metric in a consumable way' do
    http_client = StubbedHttpClient.new({"shares" => "45"})
    sut = SocialMediaMetricEnricher.new(client: http_client)
    result = sut.enrich(SimpleItem.new(url: "http://example.com"))
    expect(result[:shares]).to eq "45"
  end

  context 'When something goes wrong' do
    it 'should provide an return enrichment' do
      http_client = ErroringHttpClient.new
      sut = SocialMediaMetricEnricher.new(client: http_client)
      result = sut.enrich(SimpleItem.new)
      expect(result).to eq({})
    end
  end
end

class DummyHttpClient
  def get(uri)
    {}
  end
end

class ErroringHttpClient
  def get(uri)
    raise Exception
  end
end

class StubbedHttpClient
  def initialize(stub={})
    @stub = stub
  end
  def get(uri)
    @stub
  end
end
