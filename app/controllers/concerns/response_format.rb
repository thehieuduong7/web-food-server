module ResponseFormat
  extend ActiveSupport::Concern
  included do
    rescue_from(ActionController::ParameterMissing,
                with: lambda { |_e|
                        error_json_response 'missing parameters', 400
                      })

    rescue_from(Error::ApplicationError, with: ->(e) { error_json_response(e.to_s, e.code) })
    # rescue_from(StandardError, with: ->(e) { error_json_response(e.to_s, e.backtrace) })
  end

  # @param response {data is hash, code}
  # @param data hash
  # @param code int||nil -- 200
  def error_json_response(message, code = 500)
    render json: {
      error: {
        message: ,# message.parameterize(separator: '_').upcase,
        code:
      }
    }, status: code
  end

  # @param response {data is hash, code}
  # @param data hash
  # @param code int||nil -- 200
  def success_json_response(data = { success: true }, code = 200)
    render json: data, status: code
  end
end
