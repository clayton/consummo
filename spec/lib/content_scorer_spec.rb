require 'spec_helper'

describe 'Content Scorer' do
  it 'should score text' do
    sut = Consummo::ContentScorer.new
    expect(sut.score("hello world")).to eq(77.9)
  end

  context 'when the text is empty' do
    it 'should return a 0 score' do
      sut = Consummo::ContentScorer.new
      expect(sut.score("")).to eq(0)
    end
  end
  context 'when the text is missing' do
    it 'should return a 0 score' do
      sut = Consummo::ContentScorer.new
      expect(sut.score(nil)).to eq(0)
    end
  end
end
