class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :user_profile
  has_many :recipes

  def user_profile
    return unless object.profile_image.attached?

    Rails.application.routes.url_helpers.rails_blob_url(object.profile_image,only_path: true)
  end
end
