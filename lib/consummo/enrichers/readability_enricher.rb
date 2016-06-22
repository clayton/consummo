require "odyssey"

class ReadabilityEnricher
  def initialize(scorer: ContentScorer.new)
    @scorer = scorer
  end

  def enrich(item)
    score = @scorer.score(item.content)
    {:readability_score => score}
  end
end
