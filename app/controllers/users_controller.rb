class UsersController < ApplicationController
  before_action :authorize_admin, only: [:index]
  before_action :authorize_request,except: [:index, :create]

  def index
    @user = User.where(type:'User')
    render json:@user
  end

  def create
    @user = User.new(user_params)
    if @user.save
       render plain: 'Registration successful'
    else
       render json: {a:'Already registered!you need to login now'}
    end
  end

  def users_profile
    @users = User.select(:name,:profile_image).where(type:'User')
    render json: @users, adapter:nil
  end

  def follow
    @user = User.find(params[:id])
    if @user
     @current_user.followees << @user
     render json:@user
    end
  end

  def unfollow
    @user = User.find(params[:id])
    @followee = @current_user.followed_users.find_by(followee_id: @user.id)
    if @followee
      @followee.destroy
      render json:@user
    end
  end

  def all_followees
   @followees = @current_user.followees
   render json:@followees
  end

  def all_followers
   @followers = @current_user.followers
   render json:@followers
  end

  private
  def user_params
    params.permit(:name,:email,:password)
  end

end
