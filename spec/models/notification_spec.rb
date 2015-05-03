require 'spec_helper'

describe Notification do

  context "Relations" do
    it { should belong_to(:user) }
  end

  context "Instance methods" do
    let(:user) { create(:user) }
    let(:notification) { build(:notification, :user => user) }

    it "should build new broadcast service" do
      expect(Exodus::BroadcastDataToUser).to receive(:new)
        .with({ :method => :post, :channel => "/#{user.token}/notifications", :data => notification })
        .and_return(double(:perform => true))
      notification.broadcast
    end

    it "should execute new broadcast service" do
      service = double(:perform => true)
      allow(Exodus::BroadcastDataToUser).to receive(:new) { service }
      expect(service).to receive(:perform)
      notification.broadcast
    end
  end

end
