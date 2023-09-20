class RecipeMailer < ApplicationMailer
  default from:'info.pranascore@gmail.com'
  def post_notify
    # byebug
    @recipe= params[:recipe]

    mail(to:@recipe.user.followers.pluck(:email), subject:'A new recipe is posted, have a visit ',)
  end
end
