class FeedItem
  attr_accessor :title

  def initialize(attrs={})
    self.title = attrs[:title]
  end

  def self.create(attributes={})
    # 
  end
end
