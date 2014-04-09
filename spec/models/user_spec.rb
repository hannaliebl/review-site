require 'spec_helper'

describe User do
  before { @user = User.new(username: "example", email: "user@example.com") }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }

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

  describe "when email is invalid" do
    it "should be invalid" do
      addresses = %w[user@example,com user@example.comuser@hello.com user@ex+ample.com user@ example.com]
      addresses.each do |bademail|
        @user.email = bademail
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email is valid" do
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
end
