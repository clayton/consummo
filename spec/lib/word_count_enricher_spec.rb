require 'spec_helper'

describe 'Word Count Enrichment' do
  it 'should enrich the item with the items wordcount' do
    item = SimpleItem.new(content: "One Two Three")
    sut = WordCountEnricher.new
    expect(sut.enrich(item)).to eq({:word_count => 3})
  end

  context 'when there is no content' do
    it 'the word count should be 0' do
      item = SimpleItem.new(content: nil)
      sut = WordCountEnricher.new
      expect(sut.enrich(item)).to eq({:word_count => 0})
    end
  end
end
