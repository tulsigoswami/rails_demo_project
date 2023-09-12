class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name , :user_profile
  has_many :recipes

  def user_profile
   Rails.application.routes.url_helpers.rails_blob_url(object.profile_image, only_path: true) if object.profile_image.attached?
  end
end
