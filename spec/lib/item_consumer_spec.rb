require 'spec_helper'

describe 'Item Consumer' do
  context 'Enriching Items' do
    it 'should tell each enricher to enrich each item' do
      item = SimpleItem.new
      enricher = DummyEnricher.new
      sut = ItemConsumer.new(items: [item], enrichers: [enricher])

      expect(enricher).to receive(:enrich).with(item) { {} }
      sut.consume
    end

    it 'should merge enrichments back into the item' do
      item = SimpleItem.new
      enricher = StubbedEnricher.new({:foo => "bar"})
      sut = ItemConsumer.new(items: [item], enrichers: [enricher])

      expect(item).to receive(:attributes=).with({:foo => "bar"})
      sut.consume
    end

    it 'should replace existing values with enriched values' do
      item = SimpleItem.new(url: "http://example.com")
      enricher = StubbedEnricher.new({:url => "http://example.org"})
      sut = ItemConsumer.new(items: [item], enrichers: [enricher])
      items = sut.consume

      expect(items.first.url).to eq("http://example.org")
    end

    it 'should return a flat list of enriched items' do
      item = SimpleItem.new
      enricher = StubbedEnricher.new({:foo => "bar"})
      sut = ItemConsumer.new(items: [item], enrichers: [enricher])

      expect(sut.consume).to be_a Array
      expect(sut.consume.first).to be_a SimpleItem
      expect(sut.consume.first.attributes[:foo]).to eq("bar")
    end
  end
end

class DummyEnricher
  def enrich(item)
    {}
  end
end

class StubbedEnricher
  def initialize(stub)
    @stub = stub
  end

  def enrich(item)
    @stub
  end
end
