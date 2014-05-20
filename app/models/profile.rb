class Profile < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :about, length: { maximum: 200 }, presence: true
end