class ApplicationController < ActionController::API
  include ResponseFormat
  before_action :authenticate_user!
  def authenticate_user!
    header = request.headers['Authorization']
    raise Error::ApplicationError, Error::TypeError::UNAUTHENTICATION if header.blank?

    token = header.split(' ').last
    @current_user = AuthService.instance
                               .decoded_token(token, ENV['SECRET_KEY_ACCESS_TOKEN'])[0]
  end

  def require_admin
    @current_user ||= authenticate_user!
    raise Error::ApplicationError, Error::TypeError::FORBIDDEN if @current_user['is_admin']
  end
end
