require 'spec_helper'

describe Game do
  context "Relations" do
    it { should have_and_belong_to_many(:players) }
    it { should have_one(:board) }
  end
end
