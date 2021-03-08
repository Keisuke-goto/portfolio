class UploadController < ApplicationController
  def index
    @upload = Upload.all.page(params[:page]).per(5)
  end

  def show
    @upload = Upload.find_by(id: params[:id])
    @user = @upload.user
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(
      title: params[:title],
      target: params[:target],
      content: params[:content],
      user_id: @current_user.id
    )
    if @upload.save
      flash[:notice] = "投稿完了"
      redirect_to("/upload/index")
    else
      flash[:notice] = "投稿失敗"
      render("upload/new")
    end
  end 
end