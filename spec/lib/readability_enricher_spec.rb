require 'spec_helper'

describe 'Readability Metrics' do
  it 'should tell the readability score calculator to caclulate a score' do
      item = Consummo::SimpleItem.new(content: "Hello world!")
      scorer = Consummo::DummyReadabilityScorer.new

      sut = Consummo::ReadabilityEnricher.new(scorer: scorer)

      expect(scorer).to receive(:score).with("Hello world!")

      sut.enrich(item)
  end

  it 'should expose a simple readability score of the text' do
    item = Consummo::SimpleItem.new(content: "Hello world!")
    scorer = Consummo::StubbedReadabilityScorer.new(3.14)

    sut = Consummo::ReadabilityEnricher.new(scorer: scorer)
    expect(sut.enrich(item)).to eq({:readability_score => 3.14})
  end
end

class Consummo::DummyReadabilityScorer
  def score(text)
    0
  end
end

class Consummo::StubbedReadabilityScorer
  def initialize(stub)
    @stub = stub
  end
  def score(text)
    @stub
  end
end
