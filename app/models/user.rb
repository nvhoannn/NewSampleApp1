class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :name, presence: true
    validates :email, presence: true,
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }
    validate :password, presence: true, length: {minimum: 6}

    before_save :downcase_email

    has_secure_password

    private
    def downcase_email
        email.downcase!
end