require 'spec_helper'

describe "PasswordResets" do
  subject { page }

  describe "reset password page" do
    before { visit better_password_reset_path }

    it { should have_selector('h1', text: 'Reset Password') }
    it { should have_title(full_title('Reset Password')) }
  end
end
