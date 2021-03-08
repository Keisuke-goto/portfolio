module NotificationsHelper

    def notification_form(notification)
        @visiter = notification.visiter
        @comment = nil
        your_item = link_to 'あなたの投稿', user_item_path(notification), style:"font-weight: bold;"
        @visiter_comment = notification.comment_id
        case notification.action
         when "subscription" then
            tag.a(notification.visiter.name, href:users_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_item_path(notification.item_id), style:"font-weight: bold;")+"にいいねしました"
        end
    end

    def unchecked_notifications
    @notifications = @current_user.passive_notifications.where(checked: false)
    end
end
