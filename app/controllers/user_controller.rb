class UserController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_current_user, {only: [:edit, :update]}

  def index
    @users = User.all.page(params[:page]).per(3)
  end

  def show
    @user = User.find_by(id: params[:id])
    if  @user.id == @current_user.id
      redirect_to("/user/#{@current_user.id}/edit")
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name], 
      email: params[:email],
      password: params[:password],
      image_name:"default_user.jpg",
      self_intro:"自己紹介は未設定です"
      )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "登録が完了しました"
      redirect_to("/user/#{@user.id}")
    else
      render("user/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.self_intro = params[:self_intro]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
    if @user.save
      redirect_to("/user/#{@user.id}/edit")
    else
      render("user/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email],)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログイン完了"
      redirect_to("/upload/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("user/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def ensure_current_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/upload/index")
    end
  end

end
