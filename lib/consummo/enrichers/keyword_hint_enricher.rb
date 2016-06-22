class KeywordHintEnricher
  def initialize(keywords:[])
    @keywords = keywords
  end

  def enrich(item, keywords=[])
    modified = item.title
    list = keywords.empty? ? @keywords : keywords

    for keyword in list do
      modified = make_replacements(modified, keyword)
    end
    {hinted_title: modified}
  end

private
  def make_replacements(text, keyword)
    return nil if text.blank?
    return text unless text.match(/#{keyword}/i)
    text.gsub(/(#{keyword})/i, '<strong>\1</strong>')
  end
end
