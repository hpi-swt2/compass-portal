# the model representing a person of interest
class Person < ApplicationRecord
  include Timeable

  validates :phone_number, phone: true, allow_blank: true
  before_save :normalize_phone_number
  has_one_attached :profile_picture
  has_and_belongs_to_many :rooms
  has_and_belongs_to_many :owners, class_name: 'User', join_table: 'person_owner'

  accepts_nested_attributes_for :openingtimes, allow_destroy: true

  def formatted_phone_number
    parsed_phone = Phonelib.parse(phone_number)
    return number_to_phone(phone_number) if parsed_phone.invalid?

    parsed_phone.full_international
  end

  def name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
    person = new
    person.first_name = auth.info.first_name
    person.last_name = auth.info.last_name
    person.email = auth.info.email
    person
  end

  def search_description
    "E-Mail: #{email}"
  end

  def location_latitude
    nil
  end

  def location_longitude
    nil
  end

  private

  def normalize_phone_number
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
