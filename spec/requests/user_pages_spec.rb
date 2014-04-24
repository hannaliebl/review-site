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
        it { should have_title(user.username) }
        it { should have_selector('div.text-success', text: 'Welcome') }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.username) }
    it { should have_title(user.username) }
  end

  describe "edit account settings" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

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
