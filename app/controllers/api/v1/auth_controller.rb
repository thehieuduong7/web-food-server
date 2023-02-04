class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user!
  def login
    param = login_params
    access_token = AuthService.instance.login_service(param)
    success_json_response({ access_token: })
  end

  # * verify access token
  def verify
    param = verify_params
    user = AuthService.instance.verify_service(param[:access_token])
    user_serializer = ActiveModelSerializers::SerializableResource.new(user, serializer: V1::UserSerializer)
    success_json_response(user_serializer.as_json)
  end

  def register
    param = register_params
    access_token = AuthService.instance.register_service(param)
    success_json_response({ access_token: })
  end

  private

  # * return {email, password, is_remember}
  def login_params
    default_params = { is_remember: false }
    params.require(%i[email password])
    params.permit(:email, :password, :is_remember)
          .with_defaults(default_params).to_h.symbolize_keys
  end

  def verify_params
    params.require(:access_token)
    params.permit(:access_token).to_h.symbolize_keys
  end

  def register_params
    params.require(%i[email password password_confirmation first_name last_name
                      dob phone address])
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name,
                  :dob, :phone, :address, :avatar).to_h.symbolize_keys
  end
end
