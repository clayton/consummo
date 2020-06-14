require 'spec_helper'

describe 'Item Consumer Integration' do
  context 'Enriching' do
    xit 'should enrich all items' do
      item_a = Consummo::SimpleItem.new({:url => "http://freebeacon.com/national-security/code-pinks-dmz-trip-criticized-by-human-rights-activists/"})
      item_b = Consummo::SimpleItem.new({:url => "http://freebeacon.com/national-security/russian-bombers-flew-within-40-miles-of-n-california-coast/"})
      items = [item_a, item_b]
      enrichers = [Consummo::FacebookLikeEnricher.new]

      VCR.use_cassette("simple_item_consuming") do
        results = Consummo::ItemConsumer.new(items: items, enrichers: enrichers).consume
        expect(results.first.attributes[:facebook_likes]).to eq(171)
        expect(results.last.attributes[:facebook_likes]).to eq(28477)
      end
    end
  end
end
