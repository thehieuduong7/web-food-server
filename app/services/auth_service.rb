class AuthService < ApplicationService
  HEADER_FIELDS = {
    alg: 'HS256',
    typ: 'JWT'
  }

  # private
  def encode_token(payload, secret_key, exp = 1.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, secret_key, 'HS256', HEADER_FIELDS)
  end

  # return array [payload, header]
  def decoded_token(token, secret_key)
    JWT.decode(token, secret_key, true, algorithm: 'HS256')
  rescue JWT::DecodeError
    raise Error::Unauthorized.new("Invalid token")
  end

  # TODO: login account and return token
  # @params form {username, password, is_remember}
  # @params find_users callback find user
  def login_service(form)
    user = User.is_active.find_by!(email: form[:email])
    raise StandardError unless UsersService.instance.equal_hash?(user[:password], form[:password])
    payload = {
      **user.slice(:id, :is_admin)
    }
    exp = form[:is_remember] ? (7 * 24).hours.from_now : 24.hours.from_now
    encode_token(payload, ENV['SECRET_KEY_ACCESS_TOKEN'], exp)
  rescue StandardError
    raise Error::Unauthorized.new("Username or password incorrect")
  end

  # TODO: register
  # @params form hash
  # @params email:
  # @params password:
  # @params first_name:
  # @params last_name:
  # @params gender:
  # @params dob:
  # @params avatar:
  # @params phone:
  # @params address
  def register_service(form)
    user = User.create!(form)
    payload = {
      **user.slice(:id, :is_admin)
    }
    exp = 24.hours.from_now
    encode_token(payload, ENV['SECRET_KEY_ACCESS_TOKEN'], exp)
  rescue ActiveRecord::RecordInvalid => e
    raise Error::BadRequest(e.record.errors.full_messages[0])
  end

  # @params token string
  def verify_service(token)
    payload = decoded_token(token, ENV['SECRET_KEY_ACCESS_TOKEN'])[0]
    begin
      User.is_active.find(payload['id'])
    rescue StandardError
      raise Error::NotFound.new("Not found user")
    end
  end
end
