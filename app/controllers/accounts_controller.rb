class AccountsController < ApiController

  def index
    if params[:category_id]
      accounts = Account.where(category_id:params[:category_id])
      render json:accounts
    elsif params[:cc]
      accounts = Account.all.order(:cc)
      render json:accounts
    else
      accounts=Account.joins(:ratings).group('ratings.account_id').order('count(ratings.account_id) desc')
      render json:accounts
    end
  end
end
