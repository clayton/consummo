class FacebookLikeEnricher < SocialMediaMetricEnricher
  def metric_endpoint
    "http://graph.facebook.com/?id="
  end

  def metric_name
    "facebook_likes"
  end

  def metric_key
    "shares"
  end
end
