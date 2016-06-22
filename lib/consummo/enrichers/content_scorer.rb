class ContentScorer
  def score(text)
    return 0 if text.blank?
    Odyssey.flesch_kincaid_re(text, false)
  end
end
