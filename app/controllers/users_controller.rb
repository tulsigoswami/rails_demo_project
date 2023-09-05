class UsersController < ApplicationController
  before_action :authorize_admin, only: [:index]
  # before_action :authorize_request,except: :create
  # before_action :find_user, except: [:create, :index]

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

  def user_params
    params.permit(:name,:email,:password)
  end

end
