class UsersService < ApplicationService
  def hash_bcrypt(salt)
    BCrypt::Password.create(salt).to_s
  end

  # @params hash password is hashed
  # @params salt input password
  def equal_hash?(hash, salt)
    BCrypt::Password.new(hash) == salt
  end
end
