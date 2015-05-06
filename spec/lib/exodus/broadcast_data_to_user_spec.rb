require 'spec_helper'

describe Exodus::BroadcastDataToUser do

  describe "#initialize" do
    let(:broadcast_params) do
      { :channel => '/notifications', :data => '111' }
    end
    let(:service_object) { Exodus::BroadcastDataToUser.new(broadcast_params) }

    it "should assign data to instance variable" do
      expect(service_object.data).to eq('111')
    end

    it "should assign channel to instance variable" do
      expect(service_object.channel).to eq('/notifications')
    end
  end

  describe "#perform" do
    let(:broadcast_params) do
      { :channel => '/notifications', :data => '111' }
    end
    let(:service_object) { Exodus::BroadcastDataToUser.new(broadcast_params) }

    before do
      allow(Settings).to receive(:faye) { double(:url => 'http://faye') }
      allow(RestClient::Request).to receive(:execute)
    end

    it "should post to Faye" do
      expect(RestClient::Request).to receive(:execute)
      .with(
        :method => :post,
        :url => 'http://faye',
        :payload => {
        :message => {
        :channel => '/notifications',
        :data => '111'
      }.to_json
      },
        :timeout => 2,
        :open_timeout => 2
      )
      service_object.perform
    end
  end
end
