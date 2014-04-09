class User < ActiveRecord::Base
  before_save { self.email = email.downcase, self.username = username.downcase }
  validates :username, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
