require 'spec_helper'

describe "ProfilePages" do
  subject { page }

  describe "edit profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:profile) { FactoryGirl.create(:profile, user: user) }
    before do      
      sign_in user
      visit user_path(user)
      click_link "Edit Profile"
    end

    it { should have_selector('h1', text: 'Edit Profile') }
    it { should have_title(full_title('Edit Profile')) }

    describe "after filling in profile information" do
      before do
        fill_in "About", with: "I am very interesting"
        check "profile_lifter_type1"
        check "profile_lifter_type3"
        fill_in "Location", with: "Outer space"
      end

      describe "after saving new profile with complete information" do
        before { click_button "Save Changes" }

        it { should have_content(user.username) }
        it { should have_title(user.username) }
        it { should have_content("Profile updated") }
        it { should have_content("I am very interesting") }
        it { should have_content("Powerlifter") }
        it { should have_content("Olympic") }
        it { should have_content("Outer space") }
      end
    end

    describe "after filling in a blank section" do
      before { fill_in "About", with: "" }

      describe "after saving a blank section" do
        before { click_button "Save Changes" }

        it { should have_content(user.username) }
        it { should have_title(user.username) }
        it { should have_content("Profile updated") }
        it { should have_content("Fill out your about section") }
      end
    end
  end
end


