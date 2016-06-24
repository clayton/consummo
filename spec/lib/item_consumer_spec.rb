require 'spec_helper'

describe 'Item Consumer' do
  context 'Enriching Items' do
    it 'should tell each enricher to enrich each item' do
      item = Consummo::SimpleItem.new
      enricher = Consummo::DummyEnricher.new
      sut = Consummo::ItemConsumer.new(items: [item], enrichers: [enricher])

      expect(enricher).to receive(:enrich).with(item) { {} }
      sut.consume
    end

    it 'should merge enrichments back into the item' do
      item = Consummo::SimpleItem.new
      enricher = Consummo::StubbedEnricher.new({:foo => "bar"})
      sut = Consummo::ItemConsumer.new(items: [item], enrichers: [enricher])

      expect(item).to receive(:attributes=).with({:foo => "bar"})
      sut.consume
    end

    it 'should replace existing values with enriched values' do
      item = Consummo::SimpleItem.new(url: "http://example.com")
      enricher = Consummo::StubbedEnricher.new({:url => "http://example.org"})
      sut = Consummo::ItemConsumer.new(items: [item], enrichers: [enricher])
      items = sut.consume

      expect(items.first.url).to eq("http://example.org")
    end

    it 'should return a flat list of enriched items' do
      item = Consummo::SimpleItem.new
      enricher = Consummo::StubbedEnricher.new({:foo => "bar"})
      sut = Consummo::ItemConsumer.new(items: [item], enrichers: [enricher])

      expect(sut.consume).to be_a Array
      expect(sut.consume.first).to be_a Consummo::SimpleItem
      expect(sut.consume.first.attributes[:foo]).to eq("bar")
    end
  end
end

class Consummo::DummyEnricher
  def enrich(item)
    {}
  end
end

class Consummo::StubbedEnricher
  def initialize(stub)
    @stub = stub
  end

  def enrich(item)
    @stub
  end
end
