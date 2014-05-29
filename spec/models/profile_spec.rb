require 'spec_helper'

describe Profile do
  let(:user) { FactoryGirl.create(:user) }
  before { @profile = user.build_profile(about: "This is the about section", location: "Oregon", lifter_type1: "true", lifter_type2: "false", lifter_type3: "false", lifter_type4: "false", lifter_type5: "false", lifter_type6: "false") }

  subject { user.profile }

  it { should respond_to(:about) }
  it { should respond_to(:location) }
  it { should respond_to(:lifter_type1) }
  it { should respond_to(:lifter_type2) }
  it { should respond_to(:lifter_type3) }
  it { should respond_to(:lifter_type4) }
  it { should respond_to(:lifter_type5) }
  it { should respond_to(:lifter_type6) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { user.profile.user_id = nil }
    it { should_not be_valid }
  end

  describe "with 'about' section that is too long" do
    before { user.profile.about = "a" * 201 }
    it { should_not be_valid }
  end
end