require 'spec_helper'

describe 'Keyword Hint Enrichment' do
  before do
    @item = Consummo::FeedItem.new(title: "The quick brown fox jumps over the lazy dog")
  end
  context 'Nil text for Enrichment' do
    it 'should return a nil value' do
      sut = Consummo::KeywordHintEnricher.new(keywords: %w(Apple Banana Pear))
      result = sut.enrich(Consummo::FeedItem.new(title: nil), [])
      expect(result[:hinted_title]).to be_nil
    end
  end
  context 'Empty text for Enrichment' do
    it 'should return a nil value' do
      sut = Consummo::KeywordHintEnricher.new(keywords: %w(Apple Banana Pear))
      result = sut.enrich(Consummo::FeedItem.new(title: ""), [])
      expect(result[:hinted_title]).to be_nil
    end
  end
  context 'Default Keywords' do
    it 'should accept a list of default keywords' do
      sut = Consummo::KeywordHintEnricher.new(keywords: %w(Apple Banana Pear))
    end
    it 'should use the default keywords for enrichment' do
      sut = Consummo::KeywordHintEnricher.new(keywords: ["quick"])
      result = sut.enrich(@item, [])
      expect(result[:hinted_title]).to eq "The <strong>quick</strong> brown fox jumps over the lazy dog"
    end
  end
  context 'when no keywords are present' do
    it 'should return the original text' do
      keywords = ["foooooobaarrrrr"]
      sut = Consummo::KeywordHintEnricher.new
      result = sut.enrich(@item, keywords)
      expect(result[:hinted_title]).to eq @item.title
    end
  end
  context 'when one single word keyword' do
    it 'should modify strings in the text that match the keyword' do
      keywords = ["quick"]
      sut = Consummo::KeywordHintEnricher.new
      result = sut.enrich(@item, keywords)
      expect(result[:hinted_title]).to eq "The <strong>quick</strong> brown fox jumps over the lazy dog"
    end
  end
  context 'when one multi-word keyword' do
    it 'should modify strings in the text that match the keyword' do
      keywords = ["quick brown"]
      sut = Consummo::KeywordHintEnricher.new
      result = sut.enrich(@item, keywords)
      expect(result[:hinted_title]).to eq "The <strong>quick brown</strong> fox jumps over the lazy dog"
    end
  end
  context 'when two keywords multi-word' do
    it 'should modify strings in the text that match the keyword' do
      keywords = ["quick brown", "over the"]
      sut = Consummo::KeywordHintEnricher.new
      result = sut.enrich(@item, keywords)
      expect(result[:hinted_title]).to eq "The <strong>quick brown</strong> fox jumps <strong>over the</strong> lazy dog"
    end
  end
  context 'when cases are mismatched' do
    it 'should modify strings in the text that match the keyword' do
      keywords = ["Quick Brown"]
      sut = Consummo::KeywordHintEnricher.new
      result = sut.enrich(@item, keywords)
      expect(result[:hinted_title]).to eq "The <strong>quick brown</strong> fox jumps over the lazy dog"
    end
  end
end
