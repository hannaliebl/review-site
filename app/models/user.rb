class User < ActiveRecord::Base
  has_secure_password
  has_one :profile
  accepts_nested_attributes_for :profile
  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  before_create :create_remember_token
  attr_accessor :current_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A[A-Za-z\d]*\Z/
  validates :username, presence: true, format: { with: VALID_USERNAME_REGEX }, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, :if => :password_required?
  validates :current_password, presence: true, :on => :update, :if => :current_password_required?, :unless => lambda{ |user| user.password.blank? }

  def to_param
    username
  end

  def self.find_by_param(input)
    find_by_username(input)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.new_password_reset_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def send_password_reset
    create_password_reset_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def current_password_required?
    !persisted? || !current_password.nil?
  end

  private
    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end

    def create_password_reset_token
      self.password_reset_token = User.hash(User.new_password_reset_token)
    end
end