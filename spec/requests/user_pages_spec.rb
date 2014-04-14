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
end
