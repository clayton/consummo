class UrlEnricher
  def initialize(resolver: UrlResolver.new)
    @resolver = resolver
  end

  def enrich(item)
    resolved = @resolver.resolve(item.url)
    {url: resolved.to_s}
  end
end
