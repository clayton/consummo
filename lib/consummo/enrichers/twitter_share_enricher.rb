module Consummo
  class TwitterShareEnricher < SocialMediaMetricEnricher
    def metric_endpoint
      "http://urls.api.twitter.com/1/urls/count.json?url="
    end

    def metric_name
      "twitter_shares"
    end

    def metric_key
      "count"
    end
  end
end
