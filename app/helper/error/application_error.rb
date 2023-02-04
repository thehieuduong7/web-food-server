class Error::ApplicationError < StandardError
  attr_reader :code, :description

  # @param type error: from const error
  # @description detail error
  def initialize(type, description = nil)
    @code = type[:code]
    @description = description
    super(type[:message])
  end
end
