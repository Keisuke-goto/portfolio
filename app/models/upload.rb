class Upload < ApplicationRecord
    validates :title, {presence: true}
    validates :target, {presence: true}
    validates :content, {presence: true}
    def user
        return User.find_by(id: self.user_id)
    end

    has_many :subscriptions, dependent: :destroy
    belongs_to :user

    has_many :notifications, dependent: :destroy

    def create_notification_subscription!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and upload_id = ? and action = ? ", current_user.id, user_id, id, 'subscription'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        upload_id: id,
        visited_id: user_id,
        action: "subscription"
     )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
    end
    end

end
