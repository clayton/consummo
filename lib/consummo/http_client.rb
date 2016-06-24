module Consummo
  class HttpClient
    def get(uri)
      response = HTTParty.get(uri)
      response.to_h
    end
  end
end
