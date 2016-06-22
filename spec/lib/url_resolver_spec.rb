require 'spec_helper'

describe 'URL resolver' do
  it 'should resolve urls' do
    VCR.use_cassette('url_resolver') do
      sut = UrlResolver.new
      resolved = sut.resolve("https://httpbin.org/redirect-to?url=http%3A%2F%2Fexample.com%2F")
      expect(resolved.to_s).to eq("http://example.com/")
    end
  end
end
