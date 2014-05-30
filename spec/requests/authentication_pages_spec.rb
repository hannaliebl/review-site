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
      let!(:profile) { FactoryGirl.create(:profile, user: user) }
      before { sign_in user }

      it { should have_title(user.username) }
      it { should have_link('Submit Review') }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Account Settings', href: edit_user_path(user)) }
      it { should have_link('Edit Profile') }
      it { should have_link('Log Out', href: logout_path) }
      it { should_not have_link('Login', href: login_path) }

      describe "followed by signout" do
        before { click_link "Log Out" }
        it { should_not have_link "Profile" }
        it { should have_link "Login" }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed in users" do
      let(:user) { FactoryGirl.create(:user) }
      let!(:profile) { FactoryGirl.create(:profile, user: user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Login"
        end

        describe "after signing in do" do

          it "should render the desired protected page" do
            expect(page).to have_title('Account Settings')
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }

          it { should have_title('Login') }
        end

        describe "submitting directly to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(login_path) }
          before { sign_in user, no_capybara: true }
        end
      end

      describe "in the Profiles controller" do

        describe "visiting the edit profile page" do
          before { visit edit_user_profile_path(user) }

          it { should have_title('Login') }
        end

        describe "submitting directly to the update action" do
          before { patch user_profile_path(user) }
          specify { expect(response).to redirect_to(login_path) }
          before { sign_in user, no_capybara: true }
        end
      end
    end

    describe "for wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wronguser) { FactoryGirl.create(:user, email: "wrong@example.com", username: "wronguser") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to Users#edit action" do
        before { get edit_user_path(wronguser) }
        specify { expect(response.body).not_to match(full_title('Change Your Password')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a GET request to Profiles#edit action" do
        before { get edit_user_profile_path(wronguser) }
        specify { expect(response.body).not_to match(full_title('Change Your Password')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to Users#update action" do
        before { patch user_path(wronguser) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to Profiles#update action" do
        before { patch user_profile_path(wronguser) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end
