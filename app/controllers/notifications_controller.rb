class Users:NotificationsController < ApplicationController

    def index
        @notification = @current_user.passive_notifications

        @notification.where(checked: false).each do |notification|
            notification.update_attributes(checked: true)
    end

    def destroy_all
        @notifications = @current_user.passive_notifications.destroy_all
        redirect_to users_notifications_path
    end
end
