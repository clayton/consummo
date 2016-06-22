class FeedItemFactory
  def build(entry)
    item = SimpleItem.new({
      :title        => entry.title,
      :hinted_title => entry.title,
      :url          => entry.url,
      :author       => entry.author,
      :summary      => entry.summary,
      :published_at => sanitize_published_at(entry.published),
      :guid         => entry.id
    })

    item.attributes = {:categories   => entry.categories.join(";")} unless entry.is_a?(Feedjira::Parser::ITunesRSSItem)

    item
  end

private
  def sanitize_published_at(published)
    return Time.now if published.blank?
    return Time.now if Time.parse(published.to_s) < Time.parse('1979-01-01-01 00:00:00')
    published
  end
end
