require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  describe "login page" do
    before { visit login_path }

    it { should have_content('Login') }
    it { should have_title('Login') }

    describe "with invalid information" do
      before { click_button 'Login' }

      it { should have_title('Login') }
      it { should have_selector('div.text-error') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.text-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Login"
      end

      it { should have_title(user.username) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Log Out', href: logout_path) }
      it { should_not have_link('Log In', href: login_path) }

      describe "followed by signout" do
        before { click_link "Log Out" }
        it { should_not have_link "Profile" }
        it { should have_link "Login" }
      end
    end
  end
end
