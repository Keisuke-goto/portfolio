class SubscriptionsController < ApplicationController
    def create
        subscription = @current_user.subscriptions.new(upload_id: @upload_id)
        if subscription.save
            flash[:notice] = "応募完了"
            redirect_to("/upload/index")
        else
            flash[:notice] = "応募失敗"
            redirect_to("/upload/index")
        end
    end
end
