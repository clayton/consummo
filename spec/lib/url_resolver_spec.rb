require 'spec_helper'

describe 'URL resolver' do
  it 'should resolve urls' do
    VCR.use_cassette('url_resolver') do
      sut = Consummo::UrlResolver.new
      resolved = sut.resolve("https://nghttp2.org/httpbin/redirect-to?url=https%3A%2F%2Fexample.com&status_code=302")
      expect(resolved.to_s).to eq("https://example.com/")
    end
  end
end
