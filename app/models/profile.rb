class Profile < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :about, length: { maximum: 200 }

  def to_param
    username
  end

  def self.find_by_param(input)
    find_by_user_id(input)
  end
end