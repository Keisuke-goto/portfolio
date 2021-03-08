class User < ApplicationRecord
    validates :name, {presence: true, uniqueness: true}
    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}
    has_secure_password

    def uploads
        return Upload.where(user_id: self.id)
    end
  
  has_many :uploads, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  has_many :user_rooms
  has_many :chats

  has_many :active_notifications, class_name: "Notification", foreign_key:"visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key:"visited_id", dependent: :destroy
end
