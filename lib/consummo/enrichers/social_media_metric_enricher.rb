module Consummo
  class SocialMediaMetricEnricher
    def initialize(client: HttpClient.new)
      @client = client
    end

    def enrich(item)
      begin
        result = @client.get("#{metric_endpoint}#{URI.encode(item.url)}")
        {metric_name.to_sym => result[metric_key]}
      rescue Exception => e
        {}
      end
    end

    def metric_endpoint
      "http://example.com?id="
    end

    def metric_name
      "shares"
    end

    def metric_key
      metric_name
    end
  end
end
