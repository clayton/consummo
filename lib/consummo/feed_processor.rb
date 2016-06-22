class FeedProcessor
  def initialize(feeds = [], enrichers: [])
    @feeds = feeds
    @enrichers = enrichers
  end

  def process
    producer = ItemProducer.new(feeds: @feeds)
    consumer = ItemConsumer.new(items: producer.produce, enrichers: @enrichers)
    persist(consumer.consume)
  end

private
  def persist(items)
    items.each do |item|
      FeedItem.create(item.attributes)
    end
  end
end
