class SimpleItem
  def initialize(attributes={})
    @attributes = attributes
  end

  def attributes
    @attributes
  end

  def attributes=(attrs)
    @attributes.merge!(attrs)
  end

  def title
    @attributes[:title]
  end

  def url
    @attributes[:url]
  end

  def guid
    @attributes[:guid] || @attributes[:url] || nil
  end

  def content
    @attributes[:content] || ""
  end
end
