require 'spec_helper'

describe 'Readability Metrics' do
  it 'should tell the readability score calculator to caclulate a score' do
      item = SimpleItem.new(content: "Hello world!")
      scorer = DummyReadabilityScorer.new

      sut = ReadabilityEnricher.new(scorer: scorer)

      expect(scorer).to receive(:score).with("Hello world!")

      sut.enrich(item)
  end

  it 'should expose a simple readability score of the text' do
    item = SimpleItem.new(content: "Hello world!")
    scorer = StubbedReadabilityScorer.new(3.14)

    sut = ReadabilityEnricher.new(scorer: scorer)
    expect(sut.enrich(item)).to eq({:readability_score => 3.14})
  end
end

class DummyReadabilityScorer
  def score(text)
    0
  end
end

class StubbedReadabilityScorer
  def initialize(stub)
    @stub = stub
  end
  def score(text)
    @stub
  end
end
