class WordCountEnricher
  def enrich(item)
    wc = item.content.scan(/[[:alpha:]]+/).count
    {:word_count => wc}
  end
end
