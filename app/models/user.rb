class User < ApplicationRecord
  validates :email, :password, :first_name, :last_name,
            presence: {
              message: 'is not blank'
            }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: 'invalid' }
  validates :email, uniqueness: { message: 'is already taken' }
  validates :password, confirmation: {message: "doesn\'t match confirmation"}
  scope :is_active, -> { where(is_active: true) }

  def full_name
    first_name.blank? ? first_name : "#{last_name} #{first_name}"
  end
end
