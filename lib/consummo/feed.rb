module Consummo
  class Feed
    attr_accessor :uri

    def self.create(args={})
      Feed.new(args)
    end

    def initialize(attrs={})
      self.uri = attrs[:uri]
    end

    def id
      return self.to_s
    end
  end
end
