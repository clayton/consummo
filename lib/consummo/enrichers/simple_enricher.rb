module Consummo
  class SimpleEnricher
    def enrich(item)
      { "simple" => "enrichment" }
    end
  end
end
