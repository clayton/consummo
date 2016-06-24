module Consummo
  class ItemConsumer
    def initialize(items: [], enrichers: [])
      @items = items
      @enrichers = enrichers
    end

    def consume
      @items.flat_map do |item|
        @enrichers.each do |enricher|
          item.attributes = enricher.enrich(item)
        end
        item
      end
    end
  end
end
