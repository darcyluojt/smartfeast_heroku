class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :baskets
  def self.create_guest_user
    token = SecureRandom.uuid
    temp_email = "guest_#{token}@temporary.com"

    User.create!(
      email: temp_email,
      password: SecureRandom.hex(10),
      is_guest: true,
      guest_token: token
    )
  end

end
