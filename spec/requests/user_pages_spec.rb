require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "login page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_title(full_title('Sign Up')) }
  end
end
