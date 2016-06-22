require 'httparty'

class UrlResolver
  def resolve(url)
    return url if url.blank?
    begin
      response = HTTParty.head(url, follow_redirects: true)
      response.request.last_uri
    rescue Errno::ECONNREFUSED, URI::InvalidURIError, HTTParty::RedirectionTooDeep
      url
    end
  end
end
