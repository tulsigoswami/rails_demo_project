class UsersController < ApplicationController
  before_action :authorize_admin, only: [:index]
  before_action :authorize_request, except: %i[index create]

  def index
    @user = User.where(type: 'User')
    render json: @user # , plain: "#{url_for(:profile_image)}"
  end

  def create
    # byebug
    @user = User.new(user_params)
    if @user.blank?
      render plain: 'Please input the correct information '
    elsif @user.save
      @user.profile_image.attach(params[:profile_image])

      UserMailer.with(user: @user).welcome_mail.deliver_now
      render json: @user, plain: 'Registration successful'
    else
      render json: { message: 'Already registered!you need to login now' }
    end
  end

  def users_profile
    @users = User.select(:name, :profile_image).where(type: 'User')
    render json: @users, adapter: nil
  end

  def follow
    @user = User.find(params[:id])
    return unless @user

    @current_user.followees << @user
    render json: @user
  end

  def unfollow
    @user = User.find(params[:id])
    @followee = @current_user.followed_users.find_by(followee_id: @user.id)
    return unless @followee

    @followee.destroy
    render json: @user
  end

  def all_followees
    @followees = @current_user.followees
    render json: @followees
  end

  def all_followers
    @followers = @current_user.followers
    render json: @followers
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :profile_image)
  end
end
