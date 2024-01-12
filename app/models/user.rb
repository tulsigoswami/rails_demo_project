include Rails.application.routes.url_helpers
class User < ApplicationRecord
  self.inheritance_column = :type
  after_create :send_welcome_email

  has_secure_password
  has_one_attached :profile_image
  has_many :recipes
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  validates :first_name, :last_name,
            format: { with: /^([a-zA-Z0-9]+\s)*[a-zA-Z0-9]+$/, multiline: true, message: 'your format requirements' }, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'invalid email' },
                    presence: true, uniqueness: true
  validates :type, presence: true

  validates :password, confirmation: true #, length: { within: 8..20 }, on: :create

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    pass = BCrypt::Password.create(password)
    self.password_digest = pass
    save!
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

  def send_welcome_email
    SendEmailsJob.perform_now(self)
  end
end
