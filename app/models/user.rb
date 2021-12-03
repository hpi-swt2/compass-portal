# The model representing a user who can log in
class User < ApplicationRecord
  include Timeable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: %i[openid_connect]

  validates :phone_number, phone: true, allow_blank: true
  before_save :normalize_phone_number
  has_one_attached :profile_picture
  has_and_belongs_to_many :rooms

  # Called from app/controllers/users/omniauth_callbacks_controller.rb
  # Match OpenID Connect data to a local user object
  def self.from_omniauth(auth)
    # Check if user with provider ('openid_connect') and uid is in db, otherwise create it
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      # All information returned by OpenID Connect is passed in `auth` param

      # Generate random password, default length is 20
      # https://www.rubydoc.info/github/plataformatec/devise/Devise.friendly_token
      user.password = Devise.friendly_token[0, 20]

      set_auth_data(auth.info.first_name, auth.info.last_name)

      # Uncomment, if you are using confirmable and the provider(s) you use validate emails:
      # user.skip_confirmation!
      user.profile_picture.attach(
        io: File.open('app/assets/images/default-profile-picture.png'),
        filename: 'default-profile-picture.png',
        content_type: 'image/png'
      )
    end
  end

  def formatted_phone_number
    parsed_phone = Phonelib.parse(phone_number)
    return phone_number if parsed_phone.invalid?

    parsed_phone.full_international
  end

  # https://github.com/heartcombo/devise/wiki/OmniAuth:-Overview
  # Implement the following if you want to enable copying over data from an
  # OmniAuth provider after a user alsready has a session, i.e. is already logged in
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if (data = session["devise.openid_connect_data"]) && user.email.blank?
  #       user.email = data["email"]
  #     end
  #   end
  # end

  private

  def read_auth_data(auth)
    self.email = auth.info.email
    self.username = auth.info.name
    self.first_name = auth.info.first_name
    self.last_name = auth.info.last_name
  end

  def normalize_phone_number
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
