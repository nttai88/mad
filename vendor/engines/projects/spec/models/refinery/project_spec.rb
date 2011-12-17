require 'spec_helper'

module Refinery
  describe Project do
    describe "validations" do
      subject do
        FactoryGirl.create(:project,
        :owner_name => "Refinery CMS")
      end

      it { should be_valid }
      its(:errors) { should be_empty }
      its(:owner_name) { should == "Refinery CMS" }
    end
  end
end
