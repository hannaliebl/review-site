require 'spec_helper'

describe User do
  before { @user = User.new(username: "example", email: "user@example.com", password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.username = "a" * 31 }
    it { should_not be_valid }
  end

  describe "when username has special characters" do
    it "should be invalid" do
      usernames = %w[_user user-name user% u@ser]
      usernames.each do |badusername|
        @user.username = badusername
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when the username is made of letters and/or numbers" do
    it "should be valid" do
      usernames = %w[user 9 1000 user10 60user us345er]
      usernames.each do |validusername|
        @user.username = validusername
        expect(@user).to be_valid
      end
    end
  end

  describe "when email is not in an email format" do
    it "should be invalid" do
      addresses = %w[user@example,com user@example.comuser@hello.com user@ex+ample.com user@ example.com]
      addresses.each do |bademail|
        @user.email = bademail
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email is in a valid email format" do
    it "should be valid" do
      addresses = %w[user@example.com USeR@ex.am.ple.com us.er@example.co us+er@example.org]
      addresses.each do |goodemail|
        @user.email = goodemail
        expect(@user).to be_valid
      end
    end
  end

  describe "when email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.username = "different"
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.email = "different@example.org"
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when password is blank" do
    before do
     @user = User.new(username: "ExampleUser", email: "user@example.com",
                       password: " ", password_confirmation: " ")
   end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password = "password", @user.password_confirmation = "notsame" }
    it { should_not be_valid }
  end

  describe "when password is less than eight characters" do
    before { @user.password = @user.password_confirmation = "1234567" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(username: @user.username) }

    describe "with a valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with an invalid password" do
      let(:user_with_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_with_invalid_password }
      specify { expect(user_with_invalid_password).to be_false }
    end
  end
end
