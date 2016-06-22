require 'spec_helper'

describe 'FacebookLikeEnricher' do
  before do
    @sut = FacebookLikeEnricher.new
  end

  it 'should have the correct metric endpoint' do
    expect(@sut.metric_endpoint).to eq "http://graph.facebook.com/?id="
  end

  it 'should have the correct metric name' do
    expect(@sut.metric_name).to eq "facebook_likes"
  end
end
