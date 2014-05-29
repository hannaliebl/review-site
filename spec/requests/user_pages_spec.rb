require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_title(full_title('Sign Up')) }

  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create Account" }

    describe "with invalid information" do
      it "should not create an account" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign Up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username",               with: "exampleusername"
        fill_in "Email",                  with: "user@example.com"
        fill_in "Password",               with: "password123"
        fill_in "Password Confirmation",  with: "password123"
      end

      it "should create a user account" do
        expect { click_button submit}.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button "Create Account" }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link("Log Out") }
        it { should have_title("New Profile") }
        it { should have_selector('div.text-success', text: 'Fill out') }

        describe "after filling in new profile information" do
          before do
            fill_in "About", with: "This is my about section!"
            check "profile_lifter_type1"
            fill_in "Location", with: "Ohio"
          end

          describe "after saving new profile with complete information" do
            before { click_button "Save Profile" }

            it { should have_content(user.username) }
            it { should have_title(user.username) }
            it { should have_content("Welcome to How Many Squat Racks!") }
            it { should have_content("This is my about section!") }
            it { should have_content("Powerlifter") }
            it { should have_content("Ohio") }
          end
        end

        describe "after saving new profile with incomplete information" do
          before do
            fill_in "About", with: "This is my about section!"
            check "profile_lifter_type1"
          end

          describe "after saving new profile with incomplete information" do
            before { click_button "Save Profile" }

            it { should have_content(user.username) }
            it { should have_title(user.username) }
            it { should have_content("Welcome to How Many Squat Racks!") }
            it { should have_content("This is my about section!") }
            it { should have_content("Powerlifter") }
            it { should have_content("Fill out your location") }
          end
        end

        describe "after skipping new profile information" do
          before { click_button "Skip" }
          it { should have_content(user.username) }
          it { should have_title(user.username) }
          it { should have_content("Welcome to How Many Squat Racks!") }
          it { should have_content("Fill out your about section") }
          it { should have_content("Fill out your location") }
        end
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:profile) { FactoryGirl.create(:profile, user: user) }

    before { visit user_path(user) }

    it { should have_content(user.username) }
    it { should have_title(user.username) }

    describe "profile information" do

      it { should have_content(profile.about) }
      it { should have_content(profile.location) }
      it { should_not have_content(profile.lifter_type1) }
      it { should have_content(profile.lifter_type2) }
      it { should_not have_content(profile.lifter_type3) }
      it { should_not have_content(profile.lifter_type4) }
      it { should_not have_content(profile.lifter_type5) }
      it { should_not have_content(profile.lifter_type6) }

    end
  end

  describe "edit account settings" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:profile) { FactoryGirl.create(:profile, user: user, about: "hello") }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_title("Account Settings") }
      it { should have_content("Change Your Password") }
    end

    describe "with valid information" do
      before do
        fill_in "Old Password", with: "eightchars"
        fill_in "New Password", with: "newpassword"
        fill_in "Password Confirmation", with: "newpassword"
        click_button('Save New Password')
      end

      it { should have_content('Password changed') }
    end

    describe "with invalid information" do
      before { click_button "Save New Password" }

      it { should have_content('Incorrect') }

      describe "with new passwords that don't match" do
        before do
          fill_in "Old Password", with: "eightchars"
          fill_in "New Password", with: "newpassword1"
          fill_in "Password Confirmation", with: "newpassword"
          click_button('Save New Password')
        end

        it { should have_content('error') }
      end

      describe "with new password that isn't long enough" do
        before do
          fill_in "Old Password", with: "eightchars"
          fill_in "New Password", with: "short"
          fill_in "Password Confirmation", with: "short"
          click_button('Save New Password')
        end

        it { should have_content('error') }
      end

      describe "without the proper old password" do
        before do
          fill_in "Old Password", with: "wrongpassword"
          fill_in "New Password", with: "newpassword"
          fill_in "Password Confirmation", with: "newpassword"
          click_button('Save New Password')
        end

        it { should have_content('Incorrect') }
      end
    end
  end
end
