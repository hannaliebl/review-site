require "spec_helper"

describe UserMailer do
  # before(:each) do
  #   ActionMailer::Base.delivery_method = :test
  #   ActionMailer::Base.perform_deliveries = true
  #   ActionMailer::Base.deliveries = []
  #   @user = FactoryGirl.create(:user)
  #   let(:user) { FactoryGirl(:user, :password_reset_token => "anything") }
  #   UserMailer.password_reset(@user).deliver
  # end

  # after(:each) do
  #   ActionMailer::Base.deliveries.clear
  # end

  # it 'should send an email' do
  #   ActionMailer::Base.deliveries.count.should == 1
  # end

  # it 'renders the receiver email' do
  #   ActionMailer::Base.deliveries.first.to.should == @user.email
  # end

  # it 'should set the subject to the correct subject' do
  #   ActionMailer::Base.deliveries.first.subject.should == 'Password Reset'
  # end

  # it 'renders the sender email' do  
  #   ActionMailer::Base.deliveries.first.from.should == ['from@example.com']
  # end
  describe "password_reset" do
    let(:user) { FactoryGirl.create(:user, :password_reset_token => "anything") }
    before { visit better_password_reset_path }
    before { fill_in "Email", with: user.email }
    before { click_button "Reset Password" }
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq(["second@example.com"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match(edit_better_password_reset_path(user.password_reset_token))
    end
  end

end
