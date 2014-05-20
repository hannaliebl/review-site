require 'spec_helper'

describe Profile do
  let(:user) { FactoryGirl.create(:user) }
  before { @profile = user.build_profile(about: "This is the about section", location: "Oregon", type_of_lifter: "Powerlifter") }

  subject { @profile }

  it { should respond_to(:about) }
  it { should respond_to(:location) }
  it { should respond_to(:type_of_lifter) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @profile.user_id = nil }
    it { should_not be_valid }
  end

  describe "with 'about' section that is too long" do
    before { @profile.about = "a" * 201 }
    it { should_not be_valid }
  end
end