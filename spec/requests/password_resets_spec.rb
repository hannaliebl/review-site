require 'spec_helper'

describe "PasswordResets" do
  subject { page }

  describe "reset password page" do
    before { visit better_password_reset_path }

    it { should have_selector('h1', text: 'Reset Password') }
    it { should have_title(full_title('Reset Password')) }
  end

  describe "reset password" do
    before { visit better_password_reset_path }

    let(:submit) { "Reset Password" }

    describe "with blank information" do
      before { click_button submit }

      it { should have_content "Email sent with password reset instructions." }
    end

    describe "with any entered information" do
      before do
        fill_in "Email", with: "anyText5555$$$$"
        click_button submit
      end

      it { should have_content "Email sent with password reset instructions." }

      it "should not send a password if the address doesn't exist" do
          ActionMailer::Base.deliveries.size.should == 0
      end
    end

    describe "with a valid user email address" do
      let(:user) { FactoryGirl.create(:user) }
      before { fill_in "Email", with: user.email }
      before { click_button submit }

      it { should have_content "Email sent with password reset instructions." }
      
      it "emails a password to the user" do
        last_email.to.should include(user.email)
      end
    end
  end
end
