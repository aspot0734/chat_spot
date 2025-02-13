class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update,]}
  before_action :forbit_login_user, {only: [:login_form, :login, :new, :create]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image_name]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image_name]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
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
      image_name: "default_user.jpg"
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "登録が完了しました"
      redirect_to("/users/index")
    else
      @name = params[:name]
      @email = params[:email]
      @password = params[:password]
      @error_message = "入力されていない項目があるか、すでに同じメールアドレスが存在します"
      render("users/new")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email],)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @email = params[:email]
      @password = params[:password]
      @error_message = "メールアドレス　またはパスワードが間違っています"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login_form")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/users/index")
    end
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id).order(created_at: :desc)
  end

end
