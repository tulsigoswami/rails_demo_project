class RecipeMailer < ApplicationMailer
  default from: 'info.pranascore@gmail.com'
  def post_notify()
    @recipe = params[:recipe]
    if @recipe.content.attached?
       @filename = @recipe.id.to_s + @recipe.content.filename.extension_with_delimiter
       if ActiveStorage::Blob.service.respond_to?(:path_for)
         attachments.inline[@filename] = File.read(ActiveStorage::Blob.service.send(:path_for, @recipe.content.key))
       elsif ActiveStorage::Blob.service.respond_to?(:download)
         attachments.inline[@filename] = @recipe.content.download
       end
    end
    mail(to: @recipe.user.followers.pluck(:email), subject: "A new recipe is posted, have a visit")
  end
end
