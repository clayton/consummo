require 'spec_helper'

describe 'Consummo::SocialMediaMetricEnricher' do
  it 'should get metrics for a uri' do
    http_client = Consummo::DummyHttpClient.new
    item = Consummo::SimpleItem.new(url: "http://example.com")
    sut = Consummo::SocialMediaMetricEnricher.new(client: http_client)
    expect(http_client).to receive(:get).with("http://example.com?id=http://example.com") { {} }
    sut.enrich(item)
  end

  it 'should expose the metric in a consumable way' do
    http_client = StubbedHttpClient.new({"shares" => "45"})
    sut = Consummo::SocialMediaMetricEnricher.new(client: http_client)
    result = sut.enrich(Consummo::SimpleItem.new(url: "http://example.com"))
    expect(result[:shares]).to eq "45"
  end

  context 'When something goes wrong' do
    it 'should provide an return enrichment' do
      http_client = ErroringHttpClient.new
      sut = Consummo::SocialMediaMetricEnricher.new(client: http_client)
      result = sut.enrich(Consummo::SimpleItem.new)
      expect(result).to eq({})
    end
  end
end

class Consummo::DummyHttpClient
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
